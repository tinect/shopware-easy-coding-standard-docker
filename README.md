This is a docker image to easily run easy-coding-standard.

`--config /tmp/ecs.php` uses a recent version of shopware [ecs.php](https://github.com/shopware/platform/blob/trunk/ecs.php)
`src` is the folder of your code to check and fix

PHP 7.4:
```shell
docker run --rm -v ${PWD}:/app ghcr.io/tinect/shopware-easy-coding-standard:7.4 check --fix --config /tmp/ecs.php src
```
PHP 8.0:
```shell
docker run --rm -v ${PWD}:/app ghcr.io/tinect/shopware-easy-coding-standard:8 check --fix --config /tmp/ecs.php src
```
PHP 8.1:
```shell
docker run --rm -v ${PWD}:/app ghcr.io/tinect/shopware-easy-coding-standard:8.1 check --fix --config /tmp/ecs.php src
```

run with recent changed files:

```shell
STAGED_PHP_FILES_CMD=`git diff --name-only $(git merge-base main HEAD) | grep \\.php`
CHANGED_PHP_FILES_CMD=`git diff --name-only | grep \\.php`

if [[ -z "$CHANGED_PHP_FILES_CMD" && -z "$STAGED_PHP_FILES_CMD" ]]
then
    exit 0
fi

docker run --rm -v ${PWD}:/app ghcr.io/tinect/shopware-easy-coding-standard check --fix --config /tmp/ecs.php $STAGED_PHP_FILES_CMD $CHANGED_PHP_FILES_CMD

```