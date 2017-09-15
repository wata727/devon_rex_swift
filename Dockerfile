FROM norionomura/sourcekit:311

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    autoconf \
    build-essential \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    wget \
    zlib1g-dev \
    python-software-properties \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*

ENV RUBY_MAJOR="2.4" \
    RUBY_VERSION="2.4.2"

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN apt-get update -y \
  && apt-get install -y bison ruby \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /usr/src/ruby \
  && curl -SL "https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
    | tar -xjC /usr/src/ruby --strip-components=1 \
  && cd /usr/src/ruby \
  && autoconf \
  && ./configure --disable-install-doc \
  && make -j"$(nproc)" \
  && apt-get purge -y --auto-remove bison ruby \
  && make install \
  && rm -r /usr/src/ruby

RUN apt-get update -y && \
    apt-get install -y language-pack-en && \
    rm -rf /var/lib/apt/lists/* && \
    update-locale en_US.UTF-8

ENV LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8"
