FROM lsiobase/ubuntu:jammy-05e08486-ls73

# Pulling TARGET_ARCH from build arguments and setting ENV variable
ARG TARGETARCH
ENV ARCH_VAR=$TARGETARCH

# Add Supervisor
RUN apt-get update && apt-get install -y \
    supervisor \
    libssl3 \
    libssl-dev \
    unzip
COPY root/ /

# Grab latest version of the app, extract binaries, cleanup tmp dir
RUN if [ "$ARCH_VAR" = "amd64" ]; then ARCH_VAR=linux-x86_64; elif [ "$ARCH_VAR" = "arm64" ]; then ARCH_VAR=linux-aarch64; elif [ "$ARCH_VAR" = "arm" ]; then ARCH_VAR=linux-arm; fi \
    && curl -s https://api.github.com/repos/philippe44/AirConnect/releases/latest | grep browser_download_url | cut -d '"' -f 4 | xargs curl -L -o airconnect.zip \
    && unzip airconnect.zip -d /tmp/ \
    && mv /tmp/airupnp-$ARCH_VAR /bin/airupnp-$ARCH_VAR \
    && mv /tmp/aircast-$ARCH_VAR /bin/aircast-$ARCH_VAR \
    && chmod +x /bin/airupnp-$ARCH_VAR \
    && chmod +x /bin/aircast-$ARCH_VAR \
    && rm -r /tmp/*
