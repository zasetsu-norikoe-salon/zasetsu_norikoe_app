FROM ruby:2.6.6
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       graphviz \
                       wget
RUN mkdir /zasetsu_norikoe_app
ENV APP_ROOT /zasetsu_norikoe_app
WORKDIR $APP_ROOT

RUN gem install bundler

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Entrykitをダウンロードし、実行できるように設定
ENV ENTRYKIT_VERSION 0.4.0
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

# docker-compose up を実行するたびにbundle installを実行する
ENTRYPOINT ["prehook", "bundle install", "--"]

ADD . $APP_ROOT