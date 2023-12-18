eslint:
	npx eslint cadastre/

eslint-fix:
	npx eslint --fix cadastre/

php-cs-fixer-test:
	php-cs-fixer fix --config=.php-cs-fixer.dist.php --dry-run --diff

php-cs-fixer-apply:
	php-cs-fixer fix --config=.php-cs-fixer.dist.php

php-cs-fixer-apply-docker:
	docker run --rm -it -w=/app -v ${PWD}:/app oskarstark/php-cs-fixer-ga:latest --allow-risky=yes --config=.php-cs-fixer.dist.php
