#!/usr/bin/env bash

docker-compose build

docker-compose run --rm app rails new . --force --database=mysql --webpack=vue

cp template/puma.rb config/puma.rb

cp template/database.yml config/database.yml

cp template/grant_user.sql db/grant_user.sql

# cp template/Gemfile Gemfile

sed -i ".bak" -e "s/host: localhost/host: webpacker/g" config/webpacker.yml

sed -i ".bak" -e "s/user_name/{your user name}/g" db/grant_user.sql

docker-compose up -d

docker-compose exec db mysql -u root -p -e"$(cat db/grant_user.sql)"

docker-compose exec app rails db:create

# docker-compose run --rm app rails webpacker:install

# docker-compose run --rm app rails webpacker:install:vue

docker-compose exec app bin/yarn install

