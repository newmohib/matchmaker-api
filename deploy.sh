#!/bin/bash
docker build -t newmohib/matchmaker-api .
docker push newmohib/matchmaker-api

ssh deploy@$DEPLOY_SERVER << EOF
docker pull newmohib/matchmaker-api
docker stop matchmaker-api || true
docker rm matchmaker-api || true
docker rmi newmohib/matchmaker-api:current || true
docker tag newmohib/matchmaker-api:latest newmohib/matchmaker-api:current
docker run -d --restart always --name matchmaker-api -p 3000:3000 newmohib/matchmaker-api:current
EOF
