# README

## URL Shortener

URL shortener is an application that allows to generate shortened urls and have a top 100 board
with the most frequent accessed urls.

### Good Practices and Philosophy

I try to use good practices and motivations in the project to keep as sweet as possible. Some of them:

1. Follow 12-factor app guide from Heroku.
2. More rails specifically, thoughbot good practice guide found here is really good.
3. Angular official guide for client side.
4. Try to use concerns for encapsulating common logic related to multiple models.
5. Use modules/mixins to describe behaviors of models that can be reused. (Composition vs Inheritance)

### Architecture

The app is divided in 2 actual apps. The backend is a rails 5 api mode app and ruby 2.3.3. The frontend is
an Angular 2 client. The frontend is served totally independent from the backend.

#### API bits.

Some of the libraries we use to build our api are:
* rspec-rails for testing.
* factory_girl_rails for test data.
* active_model_serializers for building complex json if we need to.
* swagger autodiscover api, autodocument api, export api, test api.
* rubocop, style matters.
* dotenv-rails, manage environment variables.
* simplecov, we want to see we have good coverage with tests.
* ruby-critic, more automatic and static code analysis.


### Installation

We use vagrant to set up a developer flow agnostic of the host machine and stadardized process to
avoid as much as possible errors in the installation process. Vagrant will install
* ruby 2.3.3 with rbenv
* postgresql and will create a development database called `randyurl_development` and a test base called  `randyurl_test` (Please go to `vagrant/scripts/postgresql.sh` and change in lines 5 and 8 the password. Don't forget to never commit this change, we don't want sensitive data in our source files.)
* redis (we want to implement model caching for super fast url access)
* utils miscellaneous stuff
* nodejs for the client.

#### Steps for installation

1. Install `vagrant` and `virtual box`.
2. Run:
```shell 
git clone https://github.com/rvalenciano/randyurl.git /some/path/ 
```
3. Run: 

```shell 
cd /some/path/randyurl/vagrant/
vagrant up
```
4. This will run every ssh file into `vagrant/scripts` folder, installing previously mentioned components. Also will download an ubuntu 16 machine in headless mode.

5. Once it completed, run:

```shell
vagrant ssh
cd randyurl
bundle install
bin/rails rake db:migrate
bin/rails rake db:seed
bin/rails s
```

#### Running Tests

##### Unit

```shell
cd /some/path/randyurl/vagrant/
vagrant up
bin/rails db:test:prepare
vagrant ssh
cd randyurl
bin/rails db:test:prepare
bundle exec rspec spec
```

### Development

* Create a feature branch from dev branch
* Work work work
* Commit as much as possible.
* Run `rubocop -a` before each commit.
* When you feel your work is ready, create a PR to dev. Please include actual tests to your code. Both Unit and Integration.
* Merge PR to dev.
* Any sensitive data added (API_KEY, OAUTH_TOKEN, PASSWORDS) add them to the .env and .env.example (without values) to avoid having sensitive data in our source code.
* Create PR from dev to master.


### Security

We use brakeman gem to check for security issues. Run `brakeman -o report.html` to generate a decent report and
check if your code is introducing any concerning security issue.

### N + 1 queries

We use bullet for gem to check for N+1 queries or not necessary use of eager loading.