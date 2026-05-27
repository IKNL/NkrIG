# IG build environment for NkrIG (aligned with .github/workflows/main.yaml)
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8" \
    LANG=C.UTF-8

# Jekyll, Graphviz, curl, git
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gnupg \
        graphviz \
        jekyll \
        ruby-full \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Eclipse Temurin JDK 21 (matches CI)
RUN install -d -m 0755 /etc/apt/keyrings \
    && wget -qO- https://packages.adoptium.net/artifactory/api/gpg/key/public \
        | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(. /etc/os-release && echo ${VERSION_CODENAME}) main" \
        > /etc/apt/sources.list.d/adoptium.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends temurin-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22 + SUSHI
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g fsh-sushi

# IG Publisher (~100 MB) — copied into the mounted repo on first run
RUN mkdir -p /opt/ig-publisher \
    && curl -fsSL https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar \
        -o /opt/ig-publisher/publisher.jar

WORKDIR /work

COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["./_genonce.sh"]
