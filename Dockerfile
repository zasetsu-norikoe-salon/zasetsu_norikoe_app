FROM ruby:2.6.6
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs
RUN mkdir /zasetsu_norikoe_app
ENV APP_ROOT /zasetsu_norikoe_app
WORKDIR $APP_ROOT

RUN gem install bundler

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT