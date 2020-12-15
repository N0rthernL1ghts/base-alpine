ARG ALPINE_VERSION=3.12

FROM --platform=${BUILDPLATFORM} alpine:${ALPINE_VERSION} AS s6-alpine
LABEL maintainer="Aleksandar Puharic <aleksandar@puharic.com>"

ARG TARGETPLATFORM
ARG BUILDPLATFORM

# S6 Overlay
ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-${TARGETPLATFORM}.tar.gz

RUN wget -O /tmp/s6overlay.tar.gz $(echo ${S6_OVERLAY_RELEASE} | sed 's/linux\///g' | sed 's/arm64/aarch64/g' | sed 's/arm\/v7/armhf/g') \
    && tar xzf /tmp/s6overlay.tar.gz -C / \
    && rm /tmp/s6overlay.tar.gz

# S6 Config
ENV S6_KEEP_ENV=1

# Custom defintions
ENV CRON_ENABLED=false

ADD rootfs /

# Init
ENTRYPOINT [ "/init" ]
