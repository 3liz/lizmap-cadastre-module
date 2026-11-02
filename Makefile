eslint:
	npx eslint cadastre/

eslint-fix:
	npx eslint --fix cadastre/

php-cs-fixer-test:
	php-cs-fixer fix --config=.php-cs-fixer.dist.php --dry-run --diff

# Same version of PHP-CS-Fixer as Lizmap Web Client, it must match the one from .github/workflows/test-lint-php.yml
PHP_CS_FIXER_IMAGE=ghcr.io/php-cs-fixer/php-cs-fixer:3.69-php8.1

php-cs-fixer-test-docker:
	docker run --rm -u $(shell id -u):$(shell id -g) -w=/app -v ${PWD}:/app $(PHP_CS_FIXER_IMAGE) check --allow-risky=yes --diff

php-cs-fixer-apply:
	php-cs-fixer fix --config=.php-cs-fixer.dist.php

php-cs-fixer-apply-docker:
	docker run --rm -u $(shell id -u):$(shell id -g) -w=/app -v ${PWD}:/app $(PHP_CS_FIXER_IMAGE) fix --allow-risky=yes
