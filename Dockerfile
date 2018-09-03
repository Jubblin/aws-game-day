FROM amazonlinux:latest

EXPOSE 80

RUN yum -y install wget
RUN wget https://s3.amazonaws.com/ee-assets-dev-us-east-1/modules/gd2015-loadgen/v0.1/server
RUN chmod +x server
CMD ./server