FROM ubuntu:14.04.1
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
  python-reportlab python-simplejson python-yaml \
  python-decorator python-imaging python-requests python-passlib python-pyinotify \
  git bzr vim libreoffice curl openssh-server build-essential wget \ 
  python3-uno python3-pip default-jre postgresql-client xfonts-base xfonts-75dpi

# Install NodeJS and Less compiler
RUN wget -qO- https://deb.nodesource.com/setup | bash - && \
  apt-get install -y --force-yes --no-install-recommends nodejs && \
  npm install -g less less-plugin-clean-css
  
# We set the openerp user and group fixed for compatibility with connectors and hosts
RUN addgroup --gid=1000 openerp && adduser --system --uid=1000 --gid=1000 --home /home/openerp --shell /bin/bash openerp

# It's time to install aeroolib, which is used from aeroo reports
RUN apt-get install -y libcups2-dev
RUN pip install git+https://github.com/aeroo/aeroolib.git@master pycups

## aeroo docs
RUN apt-get install -y python3-pip
RUN pip3 install daemonize jsonrpc2
RUN git clone https://github.com/aeroo/aeroo_docs.git /opt/odoo/aeroo_docs
