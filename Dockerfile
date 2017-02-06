FROM ubuntu:16.04

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y --no-install-recommends install \
		software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 \
	add-apt-repository -y --update ppa:ondrej/php && \
	apt-get -y --no-install-recommends install \
		apache2 \
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

# setup Apache
COPY apache2-foreground /usr/local/bin/
COPY vhost.conf etc/apache2/sites-available/
COPY nette/ /var/www/nette/
RUN chmod g+w /var/www/nette/log /var/www/nette/temp && \
    chown www-data:www-data /var/www/nette/log /var/www/nette/temp
COPY www/ /var/www/html/
RUN mv /var/www/html/index.html /var/www/html/apache2.html && \
	a2enmod php7.0 && \
	a2enmod rewrite && \
	sed -i -e ':a;N;$!ba;s#\(/var/www/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride\) None#\1 All#g' /etc/apache2/apache2.conf && \
	a2ensite vhost

# setup debugger
RUN echo "xdebug.remote_enable=1" >> /etc/php/7.0/apache2/conf.d/20-xdebug.ini

# start things
EXPOSE 80
CMD ["apache2-foreground"]
