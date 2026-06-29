# Package generation with Docker

This project processes an FHIR IG builder package (`package.r4.tgz`) and produces a trimmed, renamed FHIR package archive.

## What the script does

`create-package.sh` performs these steps:

1. Reads `package.r4.tgz` from the input directory
2. Extracts the archive to a working `package/` folder
3. Removes unwanted files and directories (keeps JSON profiles and the `example` folder)
4. Updates `package/package.json` (removes IG metadata, sets NCR EHR profile metadata)
5. Re-compresses the result into a `.tgz` file with the name you provide

## Directory layout

```
package-generation/
├── create-package.sh      # Processing script
├── entrypoint.sh          # Docker entrypoint (maps filename argument)
├── Dockerfile
├── docker-compose.yml
├── data/
│   ├── input/
│   │   └── package.r4.tgz # IG builder package (place here before running)
│   └── output/            # Generated package is written here
└── DOCKER.md              # This file
```

Inside the container, the input directory is `/data/input` (mounted read-only from `data/input/`).

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/) (included with Docker Desktop)

## Setup

### 1. Build the image

From the project root:

```bash
docker compose build
```

### 2. Place the input package

After building the IG (e.g. with the [igbuilder Docker setup](../igbuilder/docker.readme.md)), copy `package.r4.tgz` into the input volume:

```bash
# from tools/docker/package-generation
cp ../../../output/package.r4.tgz data/input/package.r4.tgz
```

The script expects the file to be named exactly `package.r4.tgz` in `data/input/` (container path: `/data/input/package.r4.tgz`).

### 3. Run the package generator

Use the `create-package-file` service and pass the desired output filename:

```bash
docker compose run --rm create-package-file ncr-ehr-package.tgz
```

| Argument   | Description |
|------------|-------------|
| `filename` | Name of the output `.tgz` file. The file is written to `data/output/<filename>`. |

Example:

```bash
docker compose run --rm create-package-file iknl.ncr.ehr.r4.tgz
```

After a successful run, the generated package is available at:

```
data/output/<filename>
```

## Running without Docker Compose

You can also run the container directly:

```bash
docker build -t package-generation:latest .

docker run --rm \
  -v "$(pwd)/data/input:/data/input:ro" \
  -v "$(pwd)/data/output:/data/output" \
  package-generation:latest \
  ncr-ehr-package.tgz
```

## Running the script locally (Linux or WSL)

Without Docker, the script uses the original layout:

```bash
mkdir -p output
cp package.r4.tgz output/package.r4.tgz
./create-package.sh --package-name=ncr-ehr-package
```

The result is written to `package/ncr-ehr-package.tgz`.

To also copy the result to a specific output folder:

```bash
FINAL_OUTPUT_DIR=./data/output ./create-package.sh --filename=ncr-ehr-package.tgz
```

## Environment variables (Docker)

| Variable | Default | Description |
|----------|---------|-------------|
| `IG_BUILDER_OUTPUT_PATH` | `/data/input` | Directory containing `package.r4.tgz` |
| `FINAL_OUTPUT_DIR` | `/data/output` | Directory where the final `.tgz` is saved |
| `HOME_DIRECTORY` | `/app` | Working directory for intermediate files |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Package file 'package.r4.tgz' not found` | Copy the IG builder output to `data/input/package.r4.tgz` on the host (visible in the container as `/data/input/package.r4.tgz`) |
| `No package name was provided` | Pass a filename argument: `docker compose run --rm create-package-file my-package.tgz` |
| Permission errors on `data/output` | Ensure the output directory is writable: `chmod 777 data/output` (Linux) |
