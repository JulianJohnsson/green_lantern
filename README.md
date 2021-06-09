# Green Lantern by Carbo
Green Lantern is our B2C application.

It is based on Ruby on Rails and live environments are hosted on Heroku.

## Development
### Setup
Clone this repository

Install rails (if needed) `gem install rails`

Run `bundle install`

Start postgresql server locally `pg_ctl -D /usr/local/var/postgres start` on MacOS

Create local database `rails db:create`, it might require modifing local database username to match an existing database role (or creating a new one)

Migrate database `rails db:migrate`

Seed database `rails db:seed`
