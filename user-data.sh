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
image=ghcr.io/jubblin/aws-game-day:master@sha256:6c23d4c20704d201b0ae61b3b27bcda14423bf1bf30562af85f35943ca44a487
docker pull $image
docker run -p 8080:80 $image &
docker run -p 8081:80 $image &
docker run -p 8082:80 $image &
docker run -p 8083:80 $image &
