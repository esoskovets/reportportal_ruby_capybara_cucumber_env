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
            xvfb \
            libgtk-3-dev \
            libav-tools

#=========
# Firefox
#=========
ARG FIREFOX_VERSION=50.0
RUN wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

#============
# GeckoDriver
#============
ARG GECKODRIVER_VERSION=0.11.0
RUN wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
  && chmod 755 /opt/geckodriver-$GECKODRIVER_VERSION \
  && ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver

# set working directory
WORKDIR ${PROJECT_PATH}

RUN mkdir -p ${PROJECT_PATH}/features/reports
ADD ./app/Gemfile ${PROJECT_PATH}

RUN gem install bundler && \
    bundle install

# Xvfb setup
ADD ./xvfb.init /etc/init.d/xvfb
ADD ./xvfb.run /opt/xvfb_run.sh
RUN chmod a+x /etc/init.d/xvfb && \
    chmod a+x /opt/xvfb_run.sh

ENTRYPOINT ["/opt/xvfb_run.sh"]

CMD ["cucumber"]