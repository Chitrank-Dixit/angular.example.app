#Wip

![Travis build](https://travis-ci.org/omakoleg/angular.example.app.svg?branch=master)

# About

Simple sinatra / angular application. 


# Setup

rake -T

rake db:create
rake db:migrate

RACK_ENV=test rake db:migrate

RACK_ENV=development bundle exec thin start -p 4567

# Test

RAILS_ENV=test bundle exec rake db:setup --trace
RAILS_ENV=test bundle exec rspec
