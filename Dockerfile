FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ENV RAILS_ENV production
RUN gem install bundler --version=1.7.11
RUN bundle install
ADD . /myapp
RUN bundle install
CMD rake db:create && rake db:migrate assets:precompile && puma -C config/puma.rb