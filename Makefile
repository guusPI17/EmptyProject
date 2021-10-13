COMPOSE=docker-compose
PHP=$(COMPOSE) exec php
CONSOLE=$(PHP) bin/console
COMPOSER=$(PHP) composer

up:
	touch ${HOME}/.yarnrc
	chmod ugo+rw ${HOME}/.yarnrc
	mkdir -p ${HOME}/.cache/yarn
	chmod -R ugo+rwx ${HOME}/.cache/yarn
	mkdir -p ${HOME}/.yarn
	chmod -R ugo+rwx ${HOME}/.yarn
	mkdir -p ${HOME}/.composer
	chmod -R ugo+rwx ${HOME}/.composer
	@${COMPOSE} up -d

down:
	@${COMPOSE} down

clear:
	@${CONSOLE} cache:clear

migration:
	@${CONSOLE} make:migration

migrate:
	@${CONSOLE} doctrine:migrations:migrate

fixtload:
	@${CONSOLE} doctrine:fixtures:load

require:
	@${COMPOSER} require $2

encore_dev: fos_js_routes
	@${COMPOSE} run encore yarn encore dev

encore_prod: fos_js_routes
	@${COMPOSE} run encore yarn encore production

phpunit:
	@${PHP} bin/phpunit

rebuild:
	$(COMPOSE) up -d --build
	
fos_js_routes: 
	@${CONSOLE} fos:js-routing:dump --format=js --target=web/js/fos_js_routes.js
