# README

- schema 変更時

* `docker-compose run web bundle exec rake ridge:migrate`

- seed 投入

* `docker-compose exec web bundle exec rake db:seed`
