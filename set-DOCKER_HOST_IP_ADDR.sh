#!/bin/bash
# when you run docker on Windows WSL, you get host.docker.internal but you don't get a network dedicated to docker.
# when you run docker on Linux, you don't get host.docker.internal but you can get host ip via ip addr from the didicated network to docker.
# this script exports DOCKER_HOST_IP_ADDR to indicate docker host name for either case.
export DOCKER_HOST_IP_ADDR=$(hostname -I | awk '{print $1}')
export DOCKER_HOST_NAME="localhost"