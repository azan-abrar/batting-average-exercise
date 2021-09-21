# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

For running the project you need to install the following versions of Ruby and Rails.
* Rails version: 5.2.6
* Ruby Version: 2.7.3

* `rvm install "ruby-2.7.3"`
* `rvm use 2.7.3`
* `gem install bundler`
* `bundle install`

cp config/database.yml.example config/database.yml and provide correct PG DB credentials

* `rails db:create db:migrate db:seed`
* `rails s`

The sample CSVs are in `lib/csv` folder.
