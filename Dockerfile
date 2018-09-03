FROM amazonlinux:latest
RUN yum install -y httpd-devel
RUN rm /etc/httpd/conf.d/welcome.conf
COPY apache.conf /etc/httpd/conf.d
EXPOSE 80
