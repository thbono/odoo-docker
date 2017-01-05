#!/bin/bash

echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "pt_BR ISO-8859-1" >> /etc/locale.gen
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

apt-get update

apt-get install -y python-dateutil python-docutils python-feedparser python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi poppler-utils python-pip python-pypdf python-passlib python-decorator gcc python-dev mc bzr python-setuptools python-markupsafe python-reportlab-accel python-zsi python-yaml python-argparse python-openssl python-egenix-mxdatetime python-usb python-serial lptools make python-pydot python-psutil python-paramiko poppler-utils python-pdftools antiword python-requests python-xlsxwriter python-suds python-psycogreen python-ofxparse python-gevent libpq-dev libsasl2-dev libldap2-dev libssl-dev wget nodejs npm git

ln -s /usr/bin/nodejs /usr/bin/node
npm install -g less less-plugin-clean-css

adduser --system --home=/opt/odoo --group odoo

cd /opt/odoo
wget https://pypi.python.org/packages/a8/70/bd554151443fe9e89d9a934a7891aaffc63b9cb5c7d608972919a002c03c/gdata-2.0.18.tar.gz
tar zxf gdata-2.0.18.tar.gz
rm gdata-2.0.18.tar.gz
chown -R odoo: gdata-2.0.18
cd /opt/odoo/gdata-2.0.18
python setup.py install

cd /opt/odoo
wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
rm wkhtmltox-0.12.1_linux-trusty-amd64.deb
cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

git clone --depth=1 --branch=10.0 https://github.com/odoo/odoo.git odoo-10.0
chown -R odoo: odoo-10.0
pip install -r odoo-10.0/requirements.txt

echo "/opt/odoo/odoo-10.0/odoo-bin --db_host localhost --db_port 5432 --db_user odoo --db_password odoo"