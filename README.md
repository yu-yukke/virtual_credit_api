# README

- schema 変更時

* `docker-compose exec app bundle exec rake ridge:migrate`
* `docker-compose exec app bundle exec rake ridge:migrate RAILS_ENV='test'`

- seed 投入

* `docker-compose exec app bundle exec rake db:seed`

- run spec

* `docker-compose exec app bundle exec rspec`
