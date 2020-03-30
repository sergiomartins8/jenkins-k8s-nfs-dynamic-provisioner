#!/usr/bin/env bash
set -eo pipefail

IMAGE_NAME=base-build
IMAGE_VERSION=1.0

DOCKER_HUB_USERNAME=sergiomartins8

## LOGIN ON ECR
echo 'Logging into docker hub'
docker login

## BUILD IMAGE
echo 'Building docker image'
docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .

## TAG IMAGE
echo 'Tagging image'
docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_VERSION}

## UPLOAD IMAGE
echo 'Uploading image'
docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_VERSION}

docker rmi ${IMAGE_NAME}:${IMAGE_VERSION}
docker rmi ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_VERSION}
