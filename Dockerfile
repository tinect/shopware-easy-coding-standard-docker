ARG PHP=7.4

FROM php:${PHP}-cli-alpine
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="tinect/shopware-easy-coding-standard"
LABEL org.label-schema.vcs-url="https://github.com/ballerinalang/container-support"
LABEL org.label-schema.vcs-ref="https://github.com/tinect/shopware-easy-coding-standard-docker"
LABEL org.label-schema.vendor="tinect"
LABEL org.label-schema.docker.cmd="docker run --rm -v ${PWD}:/app tinect/shopware-easy-coding-standard check --fix --config /tmp/ecs.php src"

USER 1000:1000
ENV COMPOSER_HOME /tmp/composer
ENV PATH /tmp/composer/vendor/bin:$PATH
ENV SHOPWARE_TOOL_CACHE_ECS /tmp/var/cache/cs_fixer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install composer packages
RUN composer global require \
        symplify/easy-coding-standard && \
    composer global clearcache && \
    rm -rf /var/tmp/* && \
    wget -q "https://raw.githubusercontent.com/shopware/platform/trunk/ecs.php" -O /tmp/ecs.php

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["ecs"]