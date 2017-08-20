set -e

docker build -t dockerdemo-servicea .

sudo aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
sudo aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
sudo aws configure set default.region eu-west-2

set +x
loginCommand=$(sudo aws ecr get-login --no-include-email --region eu-west-2)
$loginCommand
set -x

docker tag dockerdemo-servicea 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:latest
docker push 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:latest

docker rmi dockerdemo-servicea
docker rmi 865288682694.dkr.ecr.eu-west-2.amazonaws.com/dockerdemo-servicea:latest

sudo aws ecs register-task-definition --cli-input-json file://./TaskDefinition.json
sudo aws ecs update-service --cluster dockerdemo --service DockerDemo-ECSService-9MGHG682VV2L --task-definition dockerdemo-servicea