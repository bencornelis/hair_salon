# Hair Salon

##Date
May 8, 2015

## Author
Ben Cornelis

## About

Hair salon app with the following features:

- users can add, delete, update, and view clients and stylists
- users can assign/reassign clients to stylists
- users can view the status of clients and stylists

## Installation


Retrieve the included Gemfile and Run the following command
```
bundle install
```

## Usage

### Database setup

Requires a psql database with the following commands for setup:

- psql
- CREATE DATABASE hair_salon;
- \c hair_salon;
- CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
- CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
- CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

To use the app run
```
ruby app.rb
```
Navigate in your browser to localhost:4567. Once page loads click the add word button to get started.

### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as
possible to help us fixing the possible bug. We also encourage you to help even more by forking and
sending us a pull request.


## License

MIT License. Copyright 2015
