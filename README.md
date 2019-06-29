### Basic setup for IBC-TRELLO Application

This application have have your code developed with *Ruby on Rails, HAML, CoffeeScript*. For deploy we use two environments, the first one it's on Heroku (http://ibc-trello.herokuapp.com/) and Amazon (will have the address soon)

Using the github for control of resources and project boards. With this the developers and administradors can deal with issues states.

Some relevant points

- For Development, Testing and Production should use MySQL for database
- For Staging environment should use PostgreSQL for database
- Tests are required and for most of cases use features
- Important gems: jquery, bootstrap, faker, rspec, factory_bot_rails, guard, capybara

# Proccess for coding

We have to follow suffix branchs to understand what is happing and be solved using the github board control. Some examples:

issues/add-informations-on-footer
issues/jobs-crud-actions
fixes/board-index-with-wrong-css
bugs/error-on-create-cards

All these examples must be send to github and after this the developer must go to branch page and set the informations about it. With this the administrators can see what it's been developed, what is ok and comment.

## Links

[github project](https://github.com/rodrigo-toledo-dev/ibc-trello)

[Staging](http://ibc-trello.herokuapp.com)

[Production](http://localhost/)

[developed by: rodrigo@rtoledo.inf.br](http://mailto:rodrigo@rtoledo.inf.br/)
