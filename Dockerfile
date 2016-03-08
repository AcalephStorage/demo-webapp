FROM ruby:2.2.4

MAINTAINER Acaleph "admin@acale.ph"

ADD . /root/demo-webapp
WORKDIR /root/demo-webapp

RUN gem update --system
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

EXPOSE 9292
CMD ["puma", "-e", "production"]
