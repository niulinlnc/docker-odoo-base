FROM ubuntu:14.04.1
MAINTAINER Renzo Meister <rm@jamotion.ch>

# Install needed packages
RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --force-yes --no-install-recommends python-dateutil python-feedparser python-gdata python-ldap \
  cups cups-pdf python-cups wkhtmltopdf \
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
  python3-uno python3-pip default-jre postgresql-client xfonts-base xfonts-75dpi ttf-wqy-zenhei ttf-wqy-microhei

# Add PPA and install latest version of git
RUN apt-get install -y --force-yes --no-install-recommends python-software-properties software-properties-common && \
  apt-get update && \
  apt-get install git

# Install wkhtmltopdf
#RUN wget -P /tmp http://optimate.dl.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
# dpkg -i /tmp/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
#  mv /usr/local/bin/wkhtml* /usr/bin/
  
# install wkhtmltopdf based on QT5
ADD http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb /opt/sources/wkhtmltox.deb
RUN dpkg -i /opt/sources/wkhtmltox.deb 

# Install NodeJS and Less compiler
RUN wget -qO- https://deb.nodesource.com/setup | bash - && \
  apt-get install -y --force-yes --no-install-recommends nodejs && \
  npm install -g less less-plugin-clean-css
  
# We set the openerp user and group fixed for compatibility with connectors and hosts
#RUN addgroup --gid=1000 openerp && adduser --system --uid=1000 --gid=1000 --home /home/openerp --shell /bin/bash openerp

# create the odoo user
RUN adduser --home=/opt/odoo --disabled-password --gecos "" --shell=/bin/bash odoo

# It's time to install aeroolib, which is used from aeroo reports
#RUN apt-get install -y libcups2-dev
#RUN pip install git+https://github.com/aeroo/aeroolib.git@master pycups

## aeroo docs
#RUN apt-get install -y python3-pip
#RUN pip3 install daemonize jsonrpc2
#RUN git clone https://github.com/aeroo/aeroo_docs.git /opt/odoo/aeroo_docs
