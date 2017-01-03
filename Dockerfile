FROM ruby:2.2.6
MAINTAINER Egor Soskovets (e.soskovets@invento.by)

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV PROJECT_PATH /opt/app

# Set timezone
RUN echo "Europe/Minsk" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y \
            unzip \
            qt5-default \
            libqt5webkit5-dev \
            xvfb

# set working directory
WORKDIR ${PROJECT_PATH}

RUN mkdir -p ${PROJECT_PATH}/features/reports
ADD ./app/Gemfile ${PROJECT_PATH}

RUN gem install bundler && \
    bundle install

CMD ["bundle exec cucumber"]
