FROM  centos:latest
MAINTAINER vikashashoke@gmail.com
RUN yum install -y httpd \
 zip\
 unzip
 ADD https://www.free-css.com/assets/files/free-css-templates/download/page272/yammoe.zip /var/www/html/
 WORKDIR /var/www/html/
 RUN unzip yammoe.zip
 RUN cp -rvf yammoe/* .
 RUN rm -rf yammoe yammoe.zip
 CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
 EXPOSE 80
