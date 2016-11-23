FROM ubuntu:16.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
	software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y --update ppa:ondrej/php
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
	apache2 \
	openssh-server \
	libapache2-mod-php7.0 \
	php-xdebug \
	php7.0-curl \
	php7.0-gd \
	php7.0-gmp \
	php7.0-iconv \
	php7.0-intl \
	php7.0-json \
	php7.0-mbstring \
	php7.0-opcache \
	php7.0-pdo-mysql \
	php7.0-pdo-pgsql \
	php7.0-pdo-sqlite

WORKDIR /root


# setup SSH
RUN sed -i -e 's~#PasswordAuthentication yes~PasswordAuthentication no~' /etc/ssh/sshd_config
RUN sed -i -e 's~PermitRootLogin prohibit-password~PermitRootLogin without-password~' /etc/ssh/sshd_config
RUN mkdir .ssh
RUN chmod 700 .ssh
ADD authorized_keys .ssh/authorized_keys


# setup Apache
COPY www/ /var/www/html/
RUN mv /var/www/html/index.html /var/www/html/apache2.html
RUN a2enmod php7.0
RUN a2enmod rewrite
# change apache2.conf to "AllowOverride All" in /var/www
RUN sed -i -e ':a;N;$!ba;s#\(/var/www/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride\) None#\1 All#g' /etc/apache2/apache2.conf


# setup debugger
RUN phpdismod -s cli xdebug
RUN echo "xdebug.remote_enable=1" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini


# start things
EXPOSE 22
EXPOSE 80
ADD start.sh .
CMD ./start.sh
