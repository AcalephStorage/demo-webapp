FROM wingrunr21/drone-base

MAINTAINER Acaleph "admin@acale.ph"

ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update
RUN ruby-install ruby  2.2.4
RUN /bin/bash -l -c "chruby 2.2.4 && gem install bundler --no-rdoc --no-ri"

ADD . /root/demo-webapp
WORKDIR /root/demo-webapp

RUN gem update --system 
RUN gem install bundler 
RUN bundle install

EXPOSE 9292
CMD ["puma", "-e", "production"]
