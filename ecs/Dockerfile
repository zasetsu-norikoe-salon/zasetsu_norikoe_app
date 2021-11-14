FROM --platform=linux/amd64 ruby:2.6.6
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       graphviz \
                       wget

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
apt-get install nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN mkdir /zasetsu_norikoe_app
ENV APP_ROOT /zasetsu_norikoe_app
WORKDIR $APP_ROOT

RUN gem install bundler:2.2.15

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

ADD . $APP_ROOT

RUN yarn install --check-files

RUN bundle exec rails assets:precompile RAILS_ENV=$RAILS_ENV

RUN mkdir -p $APP_ROOT/tmp/sockets
RUN mkdir $APP_ROOT/tmp/pids

VOLUME $APP_ROOT/tmp
