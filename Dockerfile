FROM ruby:2.2.4

MAINTAINER Acaleph "admin@acale.ph"

ADD . /root/demo-webapp
WORKDIR /root/demo-webapp

RUN apt-get update && apt-get upgrade
RUN gem install bundler 
RUN bundle install

EXPOSE 9292
CMD ["puma", "-e", "production"]
