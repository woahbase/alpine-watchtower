# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
ARG SRCARCH
ARG VERSION
#
# ENV \
    # DOCKER_HOST="unix:///var/run/docker.sock" \
    # DOCKER_CONFIG="/home/alpine/.docker" \
    # DOCKER_API_VERSION="1.24" \
    # DOCKER_TLS_VERIFY=false \
    # NO_COLOR=false \
    # TZ=UTC \
    # WATCHTOWER_CLEANUP=true \
    # WATCHTOWER_DEBUG=false \
    # WATCHTOWER_HTTP_API=true \
    # WATCHTOWER_HTTP_API_METRICS=true \
    # WATCHTOWER_HTTP_API_TOKEN="insecurebydefault" \
    # WATCHTOWER_INCLUDE_RESTARTING=false \
    # WATCHTOWER_INCLUDE_STOPPED=false \
    # WATCHTOWER_POLL_INTERVAL=86400 \
    # WATCHTOWER_REMOVE_VOLUMES=false \
    # WATCHTOWER_REVIVE_STOPPED=false \
    # WATCHTOWER_ROLLING_RESTART=false \
    # WATCHTOWER_TIMEOUT="10s" \
    # WATCHTOWER_TRACE=false \
    # WATCHTOWER_WARN_ON_HEAD_FAILURE=auto
    # WATCHTOWER_LABEL_ENABLE=false \
    # WATCHTOWER_MONITOR_ONLY=false \
    # WATCHTOWER_NO_PULL=false \
    # WATCHTOWER_NO_RESTART=false \
    # WATCHTOWER_NO_STARTUP_MESSAGE=false \
    # WATCHTOWER_RUN_ONCE=false \
    # WATCHTOWER_SCHEDULE="0 0 4 * * *" \
    # WATCHTOWER_SCOPE="" \
    # WATCHTOWER_NOTIFICATIONS=gotify \
    # WATCHTOWER_NOTIFICATION_GOTIFY_URL= \
    # WATCHTOWER_NOTIFICATION_GOTIFY_TOKEN=
#
RUN set -ex \
    && apk add -Uu --no-cache \
        ca-certificates \
        curl \
        tzdata \
    && echo "Using version: $SRCARCH $VERSION" \
    && curl \
        -o /tmp/watchtower_${SRCARCH}.tar.gz \
        -jSLN https://github.com/containrrr/watchtower/releases/download/v${VERSION}/watchtower_${SRCARCH}.tar.gz \
    && tar -xzf /tmp/watchtower_${SRCARCH}.tar.gz -C /usr/local/bin \
    && apk del --purge curl \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
EXPOSE 8080
#
ENTRYPOINT ["/usershell"]
CMD ["/usr/local/bin/watchtower"]
