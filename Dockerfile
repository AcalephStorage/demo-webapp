FROM ruby:2.2.4

MAINTAINER Acaleph "admin@acale.ph"

ADD . /root/demo-webapp
WORKDIR /root/demo-webapp

RUN gem update --system && \
    gem install bundler && \
    gem install minitest-reporters && \
    bundle install

EXPOSE 9292
CMD ["rackup"]
