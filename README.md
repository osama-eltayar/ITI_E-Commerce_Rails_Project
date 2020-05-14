# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
	1 - clone the project 
	2 - bundle install 
	3 - bundle exec figaro install
	4 - in config/application.yml -> add this ⬇️ 
		db_user: "your_mysql_user"
		db_password: '"your_mysql_password"'

* Database creation
	rake db:create

* Database initialization
	if there was a problem with the length
	1- use db_name;
	2- set global innodb_large_prefix=on;
	3- set global innodb_file_format=Barracuda;

* How to run
	on Heroku:
		username as admin : admin4
		password as admin : 12345678
		username as buyer : buyer2
		password as buyer : 12345678
		username as seller : seller1
		password as seller : 000000
	note: home page filter will not work untill you sign in

	Locally:
		run 'rake db:seed' then
		username as admin : admin4
		password as admin : 12345678

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
