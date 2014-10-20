# compass
#
# VERSION: see `TAG`
FROM debian:wheezy
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

# prepare unprivileged user
RUN groupadd -r compass \
    && useradd -r -g compass compass

# install system deps
ENV RUBY_VERSION 2.1.3
ENV PATH /usr/local/rvm/gems/ruby-${RUBY_VERSION}/bin:/usr/local/rvm/gems/ruby-${RUBY_VERSION}@global/bin:/usr/local/rvm/rubies/ruby-${RUBY_VERSION}/bin:$PATH:/usr/local/rvm/bin
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install curl locales procps \
    && rm -rf /var/lib/apt/lists/* \
    && localedef \
        -i en_US \
        -c \
        -f UTF-8 \
        -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && curl -sSL https://get.rvm.io | bash -s stable --ruby=${RUBY_VERSION} \
    && gem install compass
ENV LANG en_US.utf8

# configure container
USER compass
ENTRYPOINT ["compass"]
CMD ["--help"]
