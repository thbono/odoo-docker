FROM ubuntu:xenial

RUN echo "en_US ISO-8859-1" >> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "pt_BR ISO-8859-1" >> /etc/locale.gen
RUN echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

RUN apt-get update

RUN apt-get install -y python-dateutil python-docutils python-feedparser python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi poppler-utils python-pip python-pypdf python-passlib python-decorator gcc python-dev mc bzr python-setuptools python-markupsafe python-reportlab-accel python-zsi python-yaml python-argparse python-openssl python-egenix-mxdatetime python-usb python-serial lptools make python-pydot python-psutil python-paramiko poppler-utils python-pdftools antiword python-requests python-xlsxwriter python-suds python-psycogreen python-ofxparse python-gevent libpq-dev libsasl2-dev libldap2-dev libssl-dev wget nodejs npm git

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g less less-plugin-clean-css

RUN adduser --system --home=/opt/odoo --group odoo

WORKDIR /opt/odoo
RUN wget https://pypi.python.org/packages/a8/70/bd554151443fe9e89d9a934a7891aaffc63b9cb5c7d608972919a002c03c/gdata-2.0.18.tar.gz
RUN tar zxf gdata-2.0.18.tar.gz
RUN rm gdata-2.0.18.tar.gz
RUN chown -R odoo: gdata-2.0.18
WORKDIR /opt/odoo/gdata-2.0.18
RUN python setup.py install

WORKDIR /opt/odoo
RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN rm wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
RUN cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

RUN git clone --depth=1 --branch=10.0 https://github.com/odoo/odoo.git odoo-10.0
RUN chown -R odoo: odoo-10.0
RUN pip install -r odoo-10.0/requirements.txt

EXPOSE 8069

USER odoo

ENTRYPOINT ["sh", "-c", "/opt/odoo/odoo-10.0/odoo-bin --db_host $DB_HOST --db_port $DB_PORT --db_user $DB_USER --db_password $DB_PASSWORD"]