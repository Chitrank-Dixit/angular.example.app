# About

nothing yet


# Setup

rake -T

rake db:create
rake db:migrate

RACK_ENV=test rake db:migrate

RACK_ENV=development bundle exec thin start -p 4567
RACK_ENV=test bundle exec thin start -p 4567
