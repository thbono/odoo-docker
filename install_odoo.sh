#! /bin/bash

echo "Esse script é focado na instalação do Odoo V.10"
echo "com o foco em desenvolvimento"

sudo bash -c 'echo "en_US ISO-8859-1" >> /etc/locale.gen'
sudo bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen'
sudo bash -c 'echo "pt_BR ISO-8859-1" >> /etc/locale.gen'
sudo bash -c 'echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen'
sudo locale-gen

echo "Atualizando cache do sistema"
sudo apt-get update

echo "Instalando git"
sudo apt-get install git -y

echo "Instalando ##### Dependências Odoo #####"
sudo apt-get install --no-install-recommends python-pip -y
sudo apt-get install --no-install-recommends python-dev -y
sudo apt-get install --no-install-recommends build-essential -y
sudo apt-get install --no-install-recommends libxml2-dev -y
sudo apt-get install --no-install-recommends libxslt-dev -y
sudo apt-get install --no-install-recommends libsasl2-dev -y
sudo apt-get install --no-install-recommends libldap2-dev -y
sudo apt-get install --no-install-recommends libpq-dev -y
sudo apt-get install --no-install-recommends libjpeg-dev -y
sudo apt-get install --no-install-recommends nodejs -y
sudo apt-get install --no-install-recommends npm -y
sudo apt-get install node-less -y

sudo npm install -g less less-plugin-clean-css
sudo ln -s /usr/bin/nodejs /usr/bin/node

echo "Instalando ##### Dependências da Localização Brasileira #####"
sudo apt-get install --no-install-recommends python-libxml2 -y
sudo apt-get install --no-install-recommends libxmlsec1-dev -y
sudo apt-get install --no-install-recommends python-openssl -y
sudo apt-get install --no-install-recommends python-cffi -y
 
echo "##### Dependências do WKHTMLTOX #####"
sudo apt-get install --no-install-recommends zlib1g-dev -y
sudo apt-get install --no-install-recommends fontconfig -y
sudo apt-get install --no-install-recommends libfreetype6 -y
sudo apt-get install --no-install-recommends libx11-6 -y
sudo apt-get install --no-install-recommends libxext6 -y
sudo apt-get install --no-install-recommends libxrender1 -y
sudo apt-get install --no-install-recommends libjpeg-turbo8 -y

echo "##### WKHTMLTOX #####"
wget http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
rm wkhtmltox-0.12.1_linux-trusty-amd64.deb 

echo "Instalação das dependências pip"
sudo -H pip install --upgrade pip
sudo -H pip install --upgrade setuptools
sudo -H pip install Babel==1.3
sudo -H pip install Jinja2==2.7.3
sudo -H pip install Mako==1.0.1
sudo -H pip install MarkupSafe==0.23
sudo -H pip install Pillow==2.7.0
sudo -H pip install Python-Chart==1.39
sudo -H pip install PyYAML==3.11
sudo -H pip install Werkzeug==0.9.6
sudo -H pip install argparse==1.2.1
sudo -H pip install decorator==3.4.0
sudo -H pip install docutils==0.12
sudo -H pip install feedparser==5.1.3
sudo -H pip install gdata==2.0.18
sudo -H pip install gevent==1.0.2
sudo -H pip install greenlet==0.4.7
sudo -H pip install jcconv==0.2.3
sudo -H pip install lxml==3.4.1
sudo -H pip install mock==1.0.1
sudo -H pip install ofxparse==0.14
sudo -H pip install passlib==1.6.2
sudo -H pip install psutil==2.2.0
sudo -H pip install psycogreen==1.0
sudo -H pip install psycopg2==2.5.4
sudo -H pip install pyPdf==1.13
sudo -H pip install pydot==1.0.2
sudo -H pip install pyparsing==2.0.3
sudo -H pip install pyserial==2.7
sudo -H pip install python-dateutil==2.4.0
sudo -H pip install python-ldap==2.4.19
sudo -H pip install python-openid==2.2.5
sudo -H pip install pytz==2014.10
sudo -H pip install pyusb==1.0.0b2
sudo -H pip install qrcode==5.1
sudo -H pip install reportlab==3.1.44
sudo -H pip install requests==2.6.0
sudo -H pip install six==1.9.0
sudo -H pip install suds-jurko==0.6
sudo -H pip install vobject==0.6.6
sudo -H pip install wsgiref==0.1.2
sudo -H pip install XlsxWriter==0.7.7
sudo -H pip install xlwt==0.7.5
sudo -H pip install openpyxl==2.4.0-b1
sudo -H pip install boto==2.38.0
sudo -H pip install odoorpc
sudo -H pip install suds_requests
sudo -H pip install pytrustnfe
sudo -H pip install python-boleto
sudo -H pip install python-cnab
sudo -H pip install http://labs.libre-entreprise.org/frs/download.php/897/pyxmlsec-0.3.1.tar.gz
echo "Pip e seus requerimentos estão instalados."

echo "Clonando repositório git do odoo. Isso pode demorar um bom tempo"
echo "Se sua internet é lenta, recomenda-se tomar um café enquanto aguarda"
git clone --depth=1 --branch=10.0 https://github.com/odoo/odoo.git

sudo -H pip install -r odoo/requirements.txt

echo "Terminando o arquivo de configuração, quase lá"
rm ./odoo/odoo-config
echo "[options]" >> ./odoo/odoo-config
echo "addons_path=addons,odoo/addons,../odoo-brasil" >> ./odoo/odoo-config
echo "admin_passwd = admin" >> ./odoo/odoo-config
echo "auto_reload = False" >> ./odoo/odoo-config
echo "csv_internal_sep = ," >> ./odoo/odoo-config
echo "db_host = localhost" >> ./odoo/odoo-config
echo "db_maxconn = 64" >> ./odoo/odoo-config
echo "db_name = False" >> ./odoo/odoo-config
echo "db_port = False" >> ./odoo/odoo-config
echo "db_template = template0" >> ./odoo/odoo-config
echo "db_user = odoo" >> ./odoo/odoo-config
echo "db_password= odoo" >> ./odoo/odoo-config

echo "Clonando repositório odoo-brasil"
git clone https://github.com/Trust-Code/odoo-brasil.git