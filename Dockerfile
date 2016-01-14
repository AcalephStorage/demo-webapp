FROM ubuntu:trusty

MAINTAINER Acaleph "admin@acale.ph"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

RUN wget -P /root/src http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz
RUN cd /root/src; tar xvf ruby-2.2.3.tar.gz
RUN cd /root/src/ruby-2.2.3; ./configure; make install

RUN gem update --system
RUN gem install bundler
RUN gem install minitest-reporters

RUN git clone https://github.com/AcalephStorage/demo-webapp /root/demo-webapp
RUN cd /root/demo-webapp; bundle install

EXPOSE 9292
CMD ["rackup"]
