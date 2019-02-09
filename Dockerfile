FROM debian:stretch
MAINTAINER yomismo
WORKDIR /var/www/html
RUN apt-get -y update && \
    apt-get -y install apache2 libapache2-mod-php7.0 php-mysql php-gd wget && \
    rm -rf /var/www/html/* && \
    wget https://wordpress.org/latest.tar.gz && \
    tar xf latest.tar.gz && \
    mv ./wordpress/* ./ && \
    rmdir ./wordpress && \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log && \
    sed -i "s/^session.save_handler.*/session.save_handler = redis/" /etc/php/7.0/apache2/php.ini && \
    sed -i "/^session.save_handler/i_session.save_path = \"tcp://redis\"" /etc/php/7.0/apache2/php.ini 
EXPOSE 80
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]

