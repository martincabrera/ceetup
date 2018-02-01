# Ceetup, a Meetup clone

This is a Rails 5.1.4 with Ruby 2.4.1 application. As RDBMS we use SQLite. NoSQL Redis is needed for Action Cable 
and to keep track of online users.


### Cloning the application ###

* Make sure Ruby version 2.4.1 is installed and bundler gem available.
* Execute:
 ```console
git clone URL
```
* Execute:
 ```console
bundle install
```


### SQLite Setup ###

 ```console
rake db:create
```
 ```console
 rake db:migrate
```
 ```console
rake db:seed
```

### Redis Configuration ###

* Redis has to be installed in localhost and in its default port: 6379


### Specs ###

* Execute:

 ```console
bundle exec rspec
```

### How to run the application ###

* Execute:

 ```console
rails s
```

* Visit:

 ```console
http://localhost:3000
```

* Users 'user@example.com' & 'admin@example.com' are both available with password '123456'
