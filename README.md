# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Concept: model view controller

`` rails generate controller places
Running via Spring preloader in process 6119
      create  app/controllers/places_controller.rb
      invoke  erb
      create    app/views/places
      invoke  test_unit
      create    test/controllers/places_controller_test.rb
      invoke  helper
      create    app/helpers/places_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/places.coffee
      invoke    scss
      create      app/assets/stylesheets/places.scss ``

`` rails generate model place
Running via Spring preloader in process 6233
      invoke  active_record
      create    db/migrate/20191011004818_create_places.rb
      create    app/models/place.rb
      invoke    test_unit
      create      test/models/place_test.rb
      create      test/fixtures/places.yml ``

## Creating Databases

create columns in database by whats called running the migration
`` rake db:migrate ``

if you make a mistake you can undo the last migration by doing
`` rake db:rollback ``
then you can adjust the migration and run the migration again


