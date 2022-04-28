# README

## ports

### app

- `4000`

### db

- `3007`

### db_test

- `3008`

### schema

- `8080`

## create database

- `docker-compose exec app bundle exec rails db:create`

## migration

- `docker-compose exec app bundle exec rake ridge:migrate`
- `docker-compose exec app bundle exec rake ridge:migrate RAILS_ENV='test'`

## seed

- `docker-compose exec app bundle exec rails db:seed`

## run spec

- `docker-compose exec app bundle exec rspec (path/to/spec_file)`

## run rubocop

- `docker-compose exec app bundle exec rubocop`

## annotate

- `docker-compose exec app bundle exec annotate --models --show-indexes`
