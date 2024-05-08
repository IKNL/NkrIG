# NkrIG
Broncode voor de FHIR implementatiegids voor (aanlevering aan de) de Nederlandse Kankerregistratie.

### Step 1 - Install required software
This project uses [FSH](https://hl7.org/fhir/uv/shorthand/) and [sushi](https://fshschool.org/docs/sushi/). Therefore, it requires [Node.js](https://nodejs.org/en). The [IG Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) additionally requires Java to be present on the system.

Installing sushi is detailed [here](https://fshschool.org/docs/sushi/installation/). The following command might be sufficient:

```bash
npm install fsh-sushi
```

### Step 2 - Clone the repo, and initialize publishers.

```bash
# Clone the repo
git clone https://github.com/plugin-healthcare/implementation-guide.git
cd implementation-guide

# Adding executable permissions may or may not be required
chmod +x _updatePublisher.sh

# Install/update the Implementation Guide publisher.
./_updatePublisher.sh
```

### Step 3 - Compile the IG

```bash
# Adding executable permissions may or may not be required
chmod +x _genonce.sh

# Run sushi and subsequently the IG Publisher.
./_genonce.sh
```

## Troubleshooting

If sushi complains about snapshots (_"Structure Definition http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient is missing a snapshot. Snapshot is required for import."_), please follow these steps:

1. Download the following packages **with snapshots** from Simplifier:
  - [nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core) .
  - [nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020).
2. Overwrite the contents of
  - `~/.fhir/packages/nictiz.fhir.nl.r4.nl-core#0.10.0/package` with the contents of the corresponding `tgz`.
  - `~/.fhir/packages/nictiz.fhir.nl.r4.zib2020#0.10.0/package` with the contents of the corresponding `tgz`.
3. Re-run `sushi`.


> [!warning]
> The above uses version 0.10.0 of the nl-core package. Please note that version numbers may have changed the meantime.
