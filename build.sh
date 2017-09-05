#!/bin/bash

set -e

docker build -t 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT} .

set +x
loginCommand=$(sudo aws ecr get-login --no-include-email --region eu-west-2)
$loginCommand
set -x

docker push 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT}
docker rmi 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT}

sed -e "s/%GIT_SHA%/${GIT_COMMIT}/g" ./TaskDefinition.json > ./TaskDefinition-${GIT_COMMIT}.json
sudo aws ecs register-task-definition --cli-input-json file://./TaskDefinition-${GIT_COMMIT}.json

sudo aws ecs update-service --cluster dockerdemo --service DockerDemo-ECSService-1HWPSO67M3INW --task-definition dockerdemo-servicea