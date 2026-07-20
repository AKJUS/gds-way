FROM ruby:4.0.6-slim@sha256:abd7528c4df35d151e2643d5efb845e442a26e36a4babc6459bee508619137a2

EXPOSE 4567
EXPOSE 35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y --no-install-recommends nodejs build-essential curl git ca-certificates && rm -rf /var/lib/apt/lists/*

RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

ENV APP_ENV=docker

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
