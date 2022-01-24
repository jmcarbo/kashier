# Create repository

    core: Setup rails application with rspec as testing platform

    docker run -ti --rm -p 3000:3000 -v $PWD/src:/app ruby:3.1.0 bash
    apt update
    apt install -y vim

    cd /
    gem install rails -v 7.0.1
    rails new --skip-test app

    cd app
    Edit Gemfile

     group :development, :test do
    +  gem 'rspec-rails'
     end
    +
    +group :test do
    +  gem 'capybara'
    +  gem 'selenium-webdriver'
    +end

    > bundle install
    > rails generate rspec:install
    > git config --global user.email "you@example.com"
    > git config --global user.name "Your Name"

# Heroku deployment

```
 heroku apps:create kashier
 git push heroku main
 heroku run rake db:migrate
```

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
