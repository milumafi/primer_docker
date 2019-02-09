FROM debian:stretch
MAINTAINER yomismo
WORKDIR /var/www/html
RUN apt-get -y update && \
    apt-get -y install apache2 && \
    apt-get -y install wget && \
    rm -rf /var/www/html/* && \
    wget https://wordpress.org/latest.tar.gz && \
    tar xf latest.tar.gz && \
    mv ./wordpress/* ./ && \
    rmdir ./wordpress && \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log 
EXPOSE 80

