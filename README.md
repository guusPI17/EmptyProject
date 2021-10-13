# Install

1. Поменять в ``docker-compose.yml`` в ``volumes`` и ``database/volumes`` название ``postgres_main`` на свое
2. ``docker volume create --name=postgres_main``
3. ``docker-compose up --build -d``
4. ``docker-compose exec php composer install``
5. Создать БД если требуется: ``docker-compose exec php bin/console doctrine:database:create``
8. ``docker-compose run encore yarn install``
9. В ``templates/base.html.twig`` добавить строчки 
   ```
   {% block stylesheets %}
        {{ encore_entry_link_tags('css/main') }}
        {{ encore_entry_link_tags('css/bootstrap') }}
   {% endblock %}

   {% block javascripts %}
        {{ encore_entry_script_tags('common') }}
   {% endblock %}
   ```
10. ``make encore_dev``
11. Сервер запущен по адреса ``127.0.0.1``


# Docker

## Переменные окружения

Для корректной работы контейнеров необходимо установить следующие переменные (например, указав в .bashrc):
```
export UID=$(id -u)
export GID=$(id -g)
export HOME=$( getent passwd "$USER" | cut -d: -f6 )
```

## Containers

* database - postgres:alpine
* php - php-fpm 7.4 с composer
* nginx
* encore - node с установленным yarn

## Xdebug 3.1
Название сервера: DockerTest (в файле docker/php-fpm/Dockerfile)