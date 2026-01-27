# 3.4.7
FROM ruby@sha256:299b7872d1d2f9e73666ef82ea1d759f1976a8bd16367e8637e3665ff94e942d

EXPOSE 4567
EXPOSE 35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y nodejs

RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

ENV APP_ENV=docker

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
