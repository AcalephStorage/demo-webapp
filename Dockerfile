FROM ruby:2.2.4

MAINTAINER Acaleph "admin@acale.ph"

RUN useradd -d /home/demo demo

USER demo

ADD . /home/demo/demo-webapp
WORKDIR /home/demo/demo-webapp

RUN apt-get update && apt-get upgrade && \
    gem install bundler && \
    bundle install

EXPOSE 9292
CMD ["puma", "-e", "production"]
