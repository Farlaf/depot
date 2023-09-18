FROM ruby:3.1-alpine

LABEL maintainer="slepukhovoleg@gmail.com"

ARG RAILS_ROOT=/depot
ARG PACKAGES="nodejs bash build-base git gcompat openssl-dev postgresql-dev postgresql-client tzdata"

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

RUN gem install bundler

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock  ./
RUN bundle install --jobs 5

ADD . $RAILS_ROOT
ENV PATH=$RAILS_ROOT/bin:${PATH}

EXPOSE 3000
CMD bundle exec rails s -b '0.0.0.0' -p 3000
