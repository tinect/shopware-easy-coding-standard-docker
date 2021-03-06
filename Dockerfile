ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-cli-alpine

USER 1000:1000
ENV COMPOSER_HOME /tmp/composer
ENV PATH /tmp/composer/vendor/bin:$PATH
ENV SHOPWARE_TOOL_CACHE_ECS /tmp/var/cache/cs_fixer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install composer packages
RUN echo ${PHP_VERSION} && composer global require \
        symplify/easy-coding-standard && \
    composer global clearcache && \
    rm -rf /var/tmp/* && \
    wget -q "https://raw.githubusercontent.com/shopware/platform/trunk/ecs.php" -O /tmp/ecs.php

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["ecs"]