exec:
	docker exec -ti -w /app railscontainer bash

server:
	docker exec -ti -w /app railscontainer rails server -b 0.0.0.0

run:
	docker run -ti --name railscontainer --network app -p 3000:3000 -v $$PWD/src:/app ruby:3.1.0 bash

create:
	mkdir -p src
	docker rm -f railscontainer
	docker run -ti --name railscontainer -p 3000:3000 -v $$PWD/src:/app ruby:3.1.0 bash -c "apt update && apt install -y vim && gem install rails -v 7.0.1 && rails new --skip-test --database=postgresql app"

postgres:
	docker run -d --network app --name postgres -e POSTGRES_PASSWORD=apassword -e POSTGRES_USER=app postgres:14.1

network:
	docker network create app

#group :development, :test do 
#  gem "rspec-rails"
#end
#
#group :test do
#  gem 'capybara'
#  gem 'selenium-webdriver'
#end
