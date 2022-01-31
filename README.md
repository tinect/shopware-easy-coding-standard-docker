This is a docker image to easily run easy-coding-standard.

`--config /tmp/ecs.php` uses a recent version of shopware [ecs.php](https://github.com/shopware/platform/blob/trunk/ecs.php)
`src` is the folder of your code to check and fix
```shell
docker run --rm -v ${PWD}:/app ghcr.io/tinect/shopware-easy-coding-standard check --fix --config /tmp/ecs.php src
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