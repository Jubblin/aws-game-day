FROM ubuntu:22.04

EXPOSE 80

RUN apt update && apt install curl -y
RUN curl -LO  https://s3.amazonaws.com/ee-assets-dev-us-east-1/modules/gd2015-loadgen/v0.1/server2
RUN chmod +x server2
CMD ./server2
