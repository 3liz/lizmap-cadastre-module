eslint:
	npx eslint cadastre/

eslint-fix:
	npx eslint --fix cadastre/

php-cs-fixer-test:
	php-cs-fixer fix --config=.php_cs.dist --allow-risky=yes --dry-run --diff

php-cs-fixer-apply:
	php-cs-fixer fix --config=.php_cs.dist --allow-risky=yes
