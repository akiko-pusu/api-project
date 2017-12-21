FROM ruby:2.4.2
LABEL maintainer="AKIKO TAKANO / (Twitter: @akiko_pusu)" \
  description="Image to run simple rails app."

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

### install default sys packeges ###

RUN apt-get update
RUN apt-get install -qq -y \
    git vim        \
    sqlite3

RUN mkdir /app

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /app
WORKDIR /app