FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends bash tar jq findutils ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY create-package.sh entrypoint.sh /app/
RUN sed -i 's/\r$//' /app/create-package.sh /app/entrypoint.sh \
    && chmod +x /app/create-package.sh /app/entrypoint.sh

ENV IG_BUILDER_OUTPUT_PATH=/data/input \
    FINAL_OUTPUT_DIR=/data/output \
    HOME_DIRECTORY=/app

ENTRYPOINT ["/app/entrypoint.sh"]
