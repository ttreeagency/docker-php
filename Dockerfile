FROM ttreeagency/base:latest
MAINTAINER Dominique Feyer <dfeyer@ttree.ch>

ENV TTREE_VERSION=1.0.0 \
    TTREE_DATA_DIR=/data \
    FLOW_CONTEXT=Production \
    FLOW_REWRITEURLS=1

# Configure dotdeb repository
RUN apt-get install -y wget curl && \
	echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
	echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
	wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg

# Install packages
RUN apt-get update -y && \
	apt-get install -y \
    git-core \
    nginx \
    php5 \
    php5-cli \
    php5-curl \
    php5-xsl \
    php5-gd \
    php5-mcrypt \
    php5-memcache \
    php5-redis \
    php5-fpm \
    php5-mysqlnd \
    supervisor

# Configure
RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf && \
	sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf && \
	sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf && \
	echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Add configuration
ADD conf/vhost.conf /etc/nginx/sites-available/default
ADD conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD conf/php-ttree.ini /etc/php5/fpm/conf.d/999-php-ttree.ini
ADD conf/php-ttree.ini /etc/php5/cli/conf.d/999-php-ttree.ini

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

EXPOSE 80/tcp

VOLUME ["${TTREE_DATA_DIR}"]
WORKDIR ${TTREE_DATA_DIR}

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["app:start"]
