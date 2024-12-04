ARG BASE_IMAGE="cosmic"
ARG IMAGE="cosmic"
ARG TAG_VERSION="latest"

FROM scratch AS ctx
COPY / /

# Latest once COMIC releases ^_^
FROM ghcr.io/ublue-os/cosmic:41

ARG BASE_IMAGE="cosmic"
ARG IMAGE="cosmic"

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    mkdir -p /var/lib/alternatives && \
    /ctx/build.sh && \
    mv /var/lib/alternatives /staged-alternatives && \
    ostree container commit && \
    mkdir -p /var/lib && mv /staged-alternatives /var/lib/alternatives && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
