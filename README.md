# Stuyvesant Spectator API

This is the official API for the Stuyvesant Spectator. Currently it is used as a backing service
for the Spectator website, but there are plans in the future to publish it as a public API.

The application is a Rails application, with a Postgres database. Everything is published as JSON
(in either camelCase or snake_case, using [Olive Branch](https://github.com/vigetlabs/olive_branch)). It is deployed on AWS using Elastic Beanstalk

## Setting Up
* Clone the repo (`git clone https://github.com/stuyspec/stuy-spec-api.git`)
* Install Ruby. We highly suggest rbenv or rvm
* Install Rails 5.1
* Install PostgreSQL (`brew install postgres` on Mac OS)
* Run `bundle install`
* Run `rails db:create` to create the database
* Run `rails db:migrate` to migrate the database
* Run `rails db:seed` to add fake data for testing
* Run `rails server` to run the server.
## Security Specs
Security is done through security levels, an integer attribute that users have. The three possible values of security levels are: 3 - Administrator, 2 - Spec User(Spec Web content manager), 1 - Viewer. 

Format: <Controller>: <Request> - <Security levels capable of processing request>

* Articles: GET - all, POST - 2,3(however Articles have a new attribute called is_visible which only security level 3 users have access to, PUT - 2,3(same conditions as POST), DELETE - 3
* Authorships: GET - all, POST - 2,3, PUT - 2,3, DELETE - 2,3
* Comments: GET - all, POST - 1,2,3,(only their own) PUT - 1,2,3(only their own), DELETE - 1,2(only their own),3(any comment)
* Media: GET - all, POST - 2,3, PUT - 2,3, DELETE - 3
* Role: GET - all, POST - 3, PUT - 3, DELETE - 3
* Sections: GET - all, POST - 2,3(same POST conditions as articles), PUT - 2,3(same conditions as POST), DELETE - 3
* UserRoles: GET - all, POST - 3, PUT - 3, DELETE - 3
* Users: GET - 2,3, POST - all(security_level set to 1), PUT - 1,2(only their own),3(any), DELETE - 1,2(only their own),3(any)
