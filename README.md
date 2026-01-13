# NkrIG
Broncode voor de FHIR implementatiegids voor (aanlevering aan de) de Nederlandse Kankerregistratie. Bekijk de implementatiegids op: https://iknl.github.io/NkrIG/

### Step 1 - Install required software
**sushi**
This project uses [FSH](https://hl7.org/fhir/uv/shorthand/) and [sushi](https://fshschool.org/docs/sushi/). Therefore, it requires [Node.js](https://nodejs.org/en). The [IG Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) additionally requires Java to be present on the system.

Installing sushi is detailed [here](https://fshschool.org/docs/sushi/installation/). The following command might be sufficient if you're already working with [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#intro):

```bash
npm install fsh-sushi
```
**IG Publisher**
The [IG Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) requires Java and [Jekyll](https://jekyllrb.com/docs/installation/ubuntu/) to be installed.

```
# Generally a good idea
sudo apt update

# Java
sudo apt install openjdk-17-jre

# Jekyll
sudo apt-get install graphviz jekyll
```
  

### Step 2 - Clone the repo, and initialize publishers.

```bash
# Clone the repo
git clone https://github.com/IKNL/NkrIG.git
cd NkrIG

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

## Troubleshooting missing snapshots

SUSHI requires snapshots to be present in the dependencies to convert FSH to FHIR. If they are not in the package dependencies, the free Firely Terminal command line tool can inflate the packages for which snapshots are missing.

Install the free Firely Terminal command and run the inflate command:

```bash
dotnet tool install -g firely.terminal

# If not installed (unpacked in the .fhir package directory) yet:
fhir install nictiz.fhir.nl.r4.medicationprocess9@2.0.0-rc.3

fhir inflate --package nictiz.fhir.nl.r4.medicationprocess9@2.0.0-rc.3 --force
```