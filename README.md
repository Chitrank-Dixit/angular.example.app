#Wip

[![Build Status](https://travis-ci.org/omakoleg/angular.example.app.svg?branch=master)](https://travis-ci.org/omakoleg/angular.example.app)

# About

Simple sinatra / angular application. 


# Setup

bundle exec rake -T

bundle exec rake db:create
bundle exec rake db:migrate

RACK_ENV=test rake db:migrate

RACK_ENV=development bundle exec thin start -p 4567

# Test

RAILS_ENV=test bundle exec rake db:setup --trace
RAILS_ENV=test bundle exec rspec

# run the app 

./run