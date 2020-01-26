FROM amd64/alpine:edge@sha256:9898e9a51db3e20a557fe0b2a60494b97200d31f580796e664f126a24ec487cd AS s6-alpine
LABEL maintainer="Aleksandar Puharic xzero@elite7haers.net"

# S6 Overlay
ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz
ENV S6_OVERLAY_RELEASE=${S6_OVERLAY_RELEASE}
ENV S6_KEEP_ENV=1

# Custom defintions
ENV CRON_ENABLED=false

ADD rootfs /

# s6 overlay Download
ADD ${S6_OVERLAY_RELEASE} /tmp/s6overlay.tar.gz

# Build and some of image configuration
RUN apk upgrade --update --no-cache \
    && rm -rf /var/cache/apk/* \
    && tar xzf /tmp/s6overlay.tar.gz -C / \
    && rm /tmp/s6overlay.tar.gz

# Init
ENTRYPOINT [ "/init" ]
