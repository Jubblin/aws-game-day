#!/bin/bash

set -e
cd $(dirname $0)/..

eval $(aws ecr get-login --no-include-email --region us-east-1)
AWS_ECR_REPOSITORY="902825727862.dkr.ecr.eu-west-1.amazonaws.com"
AWS_ECR_REPOSITORY="453500636975.dkr.ecr.us-east-1.amazonaws.com"
container_name="mario"
build_name="${CIRCLE_BRANCH:-$USER}-${CIRCLE_BUILD_NUM:-$(date +%Y%m%d%H%M%S)}"
echo "Building $build_name"
docker build --rm=false -t $container_name .
docker tag "$container_name:latest" "$AWS_ECR_REPOSITORY/$container_name:$build_name"
docker tag "$container_name:latest" "$AWS_ECR_REPOSITORY/$container_name:latest"
docker push "$AWS_ECR_REPOSITORY/$container_name:latest"
docker push "$AWS_ECR_REPOSITORY/$container_name:$build_name"
