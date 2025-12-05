
import os
import re
import json
import glob
from typing import Dict, Any, List, Set, Optional, Tuple

INPUT_DIR = "./fsh-generated/resources"   # Hardcoded input path
OUTPUT_MD = "profiles_mermaid.md"         # Hardcoded output file
MAX_NOTE_CHARS = 600

def find_structure_def_files(root: str) -> List[str]:
    pattern = os.path.join(root, "StructureDefinition-*.json")
    files = sorted(os.path.abspath(p) for p in glob.glob(pattern))
    return files

def extract_parent_name(base_def: Optional[str]) -> Optional[str]:
    if not base_def or not isinstance(base_def, str):
        return None
    m = re.search(r'/StructureDefinition/([^/]+)$', base_def)
    if m:
        return m.group(1)
    return base_def.rstrip("/").split("/")[-1] or None

def collect_paths_from_elements(elements: List[Dict[str, Any]], root_type: Optional[str]) -> Set[str]:
    """Collect all element paths (relative to root) for class properties."""
    props: Set[str] = set()
    if not elements:
        return props
    root_prefix = f"{root_type}." if root_type else None
    for el in elements:
        path = el.get("path")
        if not isinstance(path, str):
            continue
        if root_type and path == root_type:
            continue
        rel = path
        if root_prefix and path.startswith(root_prefix):
            rel = path[len(root_prefix):]
        props.add(rel)
    return props

def _rel_path(path: str, root_type: Optional[str]) -> str:
    if not isinstance(path, str):
        return ""
    if root_type and path == root_type:
        return ""
    prefix = f"{root_type}." if root_type else ""
    return path[len(prefix):] if (prefix and path.startswith(prefix)) else path

def _targets_from_type(type_obj: Dict[str, Any]) -> List[str]:
    """Extract targetProfile(s) as readable names."""
    targets: List[str] = []
    tp = type_obj.get("targetProfile")

    def tail_after_structuredef(url: str) -> str:
        m = re.search(r'/StructureDefinition/([^/]+)$', url)
        return m.group(1) if m else url.rstrip("/").split("/")[-1]

    if isinstance(tp, list):
        for t in tp:
            targets.append(tail_after_structuredef(str(t)))
    elif isinstance(tp, str):
        targets.append(tail_after_structuredef(tp))
    return targets or ["Resource"]

def collect_reference_elements(elements: List[Dict[str, Any]], root_type: Optional[str]) -> List[Dict[str, Any]]:
    """
    Find Reference-typed elements:
    Returns list of { path, min, max, targets }
    """
    refs: List[Dict[str, Any]] = []
    if not elements:
        return refs
    for el in elements:
        path = el.get("path")
        if not isinstance(path, str):
            continue
        types = el.get("type", [])
        if not isinstance(types, list):
            continue
        ref_types = [t for t in types if t.get("code") == "Reference"]
        if not ref_types:
            continue
        rp = _rel_path(path, root_type)
        if not rp:
            continue
        minv = el.get("min", 0)
        maxv = el.get("max", "1")
        targets: List[str] = []
        for t in ref_types:
            targets.extend(_targets_from_type(t))
        # de-duplicate preserving order
        seen = set()
        targets = [x for x in targets if not (x in seen or seen.add(x))]
        refs.append({"path": rp, "min": minv, "max": maxv, "targets": targets})
    return refs

def parse_structure_definition(sd: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    if sd.get("resourceType") != "StructureDefinition":
        return None
    name = sd.get("name") or sd.get("id")
    if not name:
        return None
    sd_type = sd.get("type")
    parent = extract_parent_name(sd.get("baseDefinition")) or sd_type
    title = sd.get("title")
    description = sd.get("description")

    snapshot = sd.get("snapshot", {})
    differential = sd.get("differential", {})
    elements = None
    if isinstance(snapshot, dict) and isinstance(snapshot.get("element"), list) and snapshot["element"]:
        elements = snapshot["element"]
    elif isinstance(differential, dict) and isinstance(differential.get("element"), list):
        elements = differential["element"]
    else:
        elements = []

    props = collect_paths_from_elements(elements, sd_type)
    refs = collect_reference_elements(elements, sd_type)

    return {
        "name": name,
        "parent": parent,
        "title": title,
        "description": description,
        "properties": props,
        "references": refs,
    }

def sanitize_identifier(s: str) -> str:
    return re.sub(r"[^A-Za-z0-9_]", "_", s) or "Unnamed"

def escape_mermaid_text(s: str) -> str:
    return str(s).replace('"', '\\"')

def format_note_text(title: Optional[str], description: Optional[str]) -> Optional[str]:
    if not title and not description:
        return None
    t = f"**{title}**" if title else ""
    d = re.sub(r"\s+", " ", str(description or "")).strip()
    if len(d) > MAX_NOTE_CHARS:
        d = d[:MAX_NOTE_CHARS].rstrip() + "…"
    return escape_mermaid_text(f"{t}\\n{d}" if (t and d) else (t or d))

def make_class_block(name: str, properties: Set[str], references: List[Dict[str, Any]]) -> Tuple[str, str]:
    """
    Build Mermaid class block.
    - Lists all properties.
    - Annotates Reference paths as: 'path (Reference → Target | Target)[*]'
    """
    cid = sanitize_identifier(name)
    header = f'class {cid}["{escape_mermaid_text(name)}"] ' + "{"
    lines = [header]

    # Index references by path for annotation in property list
    ref_by_path: Dict[str, Dict[str, Any]] = {r["path"]: r for r in references}

    if properties:
        for p in sorted(properties):
            if p in ref_by_path:
                r = ref_by_path[p]
                targets = " | ".join(r.get("targets", []) or ["Resource"])
                many = r.get("max") == "*"
                suffix = "[*]" if many else ""
                lines.append(f'  - {escape_mermaid_text(p)} (Reference → {escape_mermaid_text(targets)}){suffix}')
            else:
                lines.append(f'  - {escape_mermaid_text(p)}')
    else:
        lines.append('  - (no elements)')

    lines.append("}")
    return "\n".join(lines) + "\n", cid  # newline after block

def build_mermaid(profiles: Dict[str, Dict[str, Any]]) -> str:
    """
    Two-phase:
      1) Collect all classes (profiles + parents + ref targets).
      2) Render each class once. Then add deduplicated edges.
    """
    # Phase 1: gather all class names
    classes_to_render: Dict[str, Dict[str, Any]] = {}

    # Start with real profiles and their data
    for name, info in profiles.items():
        classes_to_render[name] = {
            "properties": info.get("properties", set()),
            "references": info.get("references", []),
            "title": info.get("title"),
            "description": info.get("description"),
            "is_stub": False,
        }

    # Add parents (as stubs if missing)
    for name, info in profiles.items():
        parent = info.get("parent")
        if parent and parent != name and parent not in classes_to_render:
            classes_to_render[parent] = {
                "properties": set(),
                "references": [],
                "title": None,
                "description": None,
                "is_stub": True,
            }

    # Add reference targets (as stubs if missing)
    for name, info in profiles.items():
        for r in info.get("references", []):
            for tgt in r.get("targets", []):
                if tgt not in classes_to_render:
                    classes_to_render[tgt] = {
                        "properties": set(),
                        "references": [],
                        "title": None,
                        "description": None,
                        "is_stub": True,
                    }

    # Phase 2: render classes once and build maps
    class_blocks: List[str] = []
    notes: List[str] = []
    id_map: Dict[str, str] = {}

    for name in sorted(classes_to_render.keys()):
        data = classes_to_render[name]
        block, cid = make_class_block(name, data["properties"], data["references"])
        class_blocks.append(block)
        id_map[name] = cid
        if not data["is_stub"]:
            note_text = format_note_text(data.get("title"), data.get("description"))
            if note_text:
                notes.append(f'note for {cid} "{note_text}"')

    # Build edges (deduplicated)
    edge_set: Set[Tuple[str, str, str]] = set()
    edges: List[str] = []

    # Inheritance
    for name, info in profiles.items():
        parent = info.get("parent")
        if not parent or parent == name:
            continue
        src = id_map[parent]
        dst = id_map[name]
        sig = (src, dst, "<|--")
        if sig not in edge_set:
            edges.append(f'{src} <|-- {dst}')
            edge_set.add(sig)

    # Reference associations
    for name, info in profiles.items():
        src_id = id_map[name]
        for r in info.get("references", []):
            label = f'{r["path"]} [{r.get("min", 0)}..{r.get("max", "1")}]'
            label_esc = escape_mermaid_text(label)
            for tgt in r.get("targets", []):
                dst_id = id_map[tgt]
                sig = (src_id, dst_id, label_esc)
                if sig not in edge_set:
                    edges.append(f'{src_id} --> {dst_id} : {label_esc}')
                    edge_set.add(sig)

    parts = ["```mermaid", "classDiagram","direction LR"]
    parts.extend(class_blocks)
    if notes:
        parts.append("")
        parts.extend(notes)
    if edges:
        parts.append("")
        parts.extend(edges)
    parts.append("```")
    return "\n".join(parts) + "\n"  # trailing newline

def write_mermaid_md(profiles: Dict[str, Dict[str, Any]], out_path: str):
    content = build_mermaid(profiles)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("# StructureDefinitions (Mermaid)\n\n")
        f.write(content)
        f.write("\n\n")  # ensure EOF newline(s)

def main():
    files = find_structure_def_files(INPUT_DIR)
    if not files:
        print(f"No StructureDefinition-*.json files found in {INPUT_DIR}")
        return

    profiles: Dict[str, Dict[str, Any]] = {}
    for p in files:
        try:
            with open(p, "r", encoding="utf-8") as f:
                sd = json.load(f)
        except Exception:
            continue
        rec = parse_structure_definition(sd)
        if not rec:
            continue
        name = rec["name"]
        if name not in profiles:
            profiles[name] = rec
        else:
            # merge properties
            profiles[name]["properties"].update(rec["properties"])
            # merge references (unique by path + targets signature)
            existing = {(r["path"], tuple(r.get("targets", []))) for r in profiles[name].get("references", [])}
            for r in rec.get("references", []):
                sig = (r["path"], tuple(r.get("targets", [])))
                if sig not in existing:
                    profiles[name].setdefault("references", []).append(r)
            # prefer first non-empty metadata
            if not profiles[name].get("title") and rec.get("title"):
                profiles[name]["title"] = rec["title"]
            if not profiles[name].get("description") and rec.get("description"):
                profiles[name]["description"] = rec["description"]
            if not profiles[name].get("parent") and rec.get("parent"):
                profiles[name]["parent"] = rec["parent"]

    write_mermaid_md(profiles, OUTPUT_MD)
    print(f"Parsed {len(profiles)} StructureDefinitions.")
    print(f"Wrote Mermaid Markdown: {OUTPUT_MD}")

if __name__ == "__main__" :
    main()
