FROM ubuntu:12.04
MAINTAINER Renzo Meister <rm@jamotion.ch>

# Install needed packages
RUN apt-get update && \
  apt-get install -y --force-yes --no-install-recommends python-dateutil python-feedparser python-gdata python-ldap \
  python-libxslt1 python-lxml python-mako python-openid python-psycopg2 \ 
  python-pybabel python-pychart python-pydot python-pyparsing python-reportlab \ 
  python-simplejson python-tz python-vatnumber python-vobject python-webdav \ 
  python-werkzeug python-xlwt python-yaml python-zsi python-docutils \ 
  python-psutil wget python-unittest2 python-mock python-jinja2 \
  python-dev libpq-dev poppler-utils python-pdftools antiword python-setuptools python-pybabel \
  python-geoip python-gevent python-ldap python-lxml python-markupsafe python-pip \
  python-psutil python-psycopg2 python-pychart python-pydot python-pypdf \
  python-reportlab python-simplejson python-yaml python-uno \
  python-decorator python-imaging python-requests python-passlib python-pyinotify \
  git bzr vim libreoffice curl openssh-server build-essential wget

# Install PostgreSQL 9.3 client
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  apt-get install -y --force-yes postgresql-client-9.3

# Install NodeJS and Less compiler
RUN mkdir -p /tmp/nodejs && \
 cd /tmp/nodejs && curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1 && \
 cd /tmp/nodejs && ./configure && make install

RUN curl -L https://npmjs.org/install.sh | sh && \
  npm install less

# We set the openerp user and group fixed for compatibility with connectors and hosts
RUN addgroup --gid=1000 openerp && adduser --system --uid=1000 --gid=1000 --home /home/openerp --shell /bin/bash openerp

# Install newest version of wkhtmltopdf
RUN cd /tmp && wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb &&\
    dpkg -i /tmp/wkhtmltox-0.12.1_linux-trusty-amd64.deb

# We install the pycharm egg hardly for remote debugging
ADD pycharm-debug.egg /tmp/pycharm-debug.egg
RUN easy_install /tmp/pycharm-debug.egg

# It's time to install aeroolib, which is used from aeroo reports
RUN cd /tmp && git clone https://github.com/jamotion/aeroolib.git; \
    cd /tmp/aeroolib && python setup.py install
