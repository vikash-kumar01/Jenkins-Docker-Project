FROM  centos:latest
MAINTAINER vikashashoke@gmail.com
RUN yum install -y httpd \
 zip\
 unzip
 ADD https://www.free-css.com/assets/files/free-css-templates/download/page267/solitude.zip /var/www/html/
 WORKDIR /var/www/html/
 RUN unzip solitude.zip
 RUN cp -rvf solitude/* .
 RUN rm -rf solitude solitude.zip
 CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
 EXPOSE 80
