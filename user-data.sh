#!/bin/bash

yum -y update
yum install -y docker
service docker start
yum install -y httpd-devel
rm /etc/httpd/conf.d/welcome.conf
cat > /etc/httpd/conf.d/lb.conf <<EOF
ProxyRequests off

<Proxy balancer://mycluster>
    BalancerMember http://127.0.0.1:8080
    BalancerMember http://127.0.0.1:8081
    BalancerMember http://127.0.0.1:8082
    BalancerMember http://127.0.0.1:8083

    ProxySet lbmethod=byrequests
</Proxy>

ProxyPass / balancer://mycluster/
EOF
service httpd start
eval $(aws ecr get-login --region us-east-1 --no-include-email)
image=453500636975.dkr.ecr.us-east-1.amazonaws.com/mario:latest
docker pull $image
docker run -p 80:8080 $image &
docker run -p 80:8081 $image &
docker run -p 80:8082 $image &
docker run -p 80:8083 $image &
