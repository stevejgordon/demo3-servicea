#!/bin/bash

set -e

sudo docker build -t 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT} .

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
sudo aws configure set default.region eu-west-2

set +x
sudo $(sudo aws ecr get-login --no-include-email --region eu-west-2)
set -x

sudo docker push 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT}
sudo docker rmi 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:${GIT_COMMIT}

sed -e "s/%GIT_SHA%/${GIT_COMMIT}/g" ./TaskDefinition.json > ./TaskDefinition-${GIT_COMMIT}.json
sudo aws ecs register-task-definition --cli-input-json file://./TaskDefinition-${GIT_COMMIT}.json

sudo aws ecs update-service --cluster dockerdemo --service DockerDemo-ECSService-72LBGBZELX2K --task-definition dockerdemo-servicea