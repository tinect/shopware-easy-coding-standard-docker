ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-cli-alpine

RUN apk update && apk add icu-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

USER 1000:1000
ENV COMPOSER_HOME /tmp/composer
ENV PATH /tmp/composer/vendor/bin:$PATH
ENV SHOPWARE_TOOL_CACHE_ECS /tmp/var/cache/cs_fixer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install composer packages
RUN echo ${PHP_VERSION} && composer global require \
        kubawerlos/php-cs-fixer-custom-fixers:~v3.14.0 symplify/easy-coding-standard:~11.3.4 friendsofphp/php-cs-fixer:~v3.17.0 && \
    composer global clearcache && \
    rm -rf /var/tmp/* && \
    wget -q "https://raw.githubusercontent.com/shopware/shopware/trunk/ecs.php" -O /tmp/ecs.php

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["ecs"]
