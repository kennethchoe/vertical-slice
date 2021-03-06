# vertical-slice

A tracerbullet for linux development on WSL.

## Goals

1. Be able to develop full stack with debug and watch capability with VSCode DevContainer.
2. Produce configurable containers for deployment.

## How to Use

Tested on Windows 10 20H2 OS Build 19042.867.

1. Install WSL 2, Ubuntu and Windows Terminal (optional).
2. Clone the repo on WSL 2 filesystem.
3. On WSL, run `open-dev.sh` to start VS Code, then click Reopen in Container on each VS Code.
4. On each VS Code, F5 to launch the app.
    - vue-app runs in watch mode. Any changes are HMRed.
    - web-api runs in debug mode. You can put breakpoint in VS Code.
    - To run web-api in watch mode, you have to stop the debug, and run `dotnet watch run src/web-api` on the terminal. 
    -  Make sure to put `/vue-app` or `/web-dotvvm` at the end of url, like `http://localhost:12345/vue-app`.
5. Make changes.
6. Run `build.sh` to build docker images.
7. Run `run.sh` to instantiate docker containers in dev mode.
    - dev mode in web-api does not redirect http to https.
    - Open http://localhost:8082/vue-app and http://localhost:8084/web-dotvvm to see the app running.
8. Do git commit/push in WSL console. (That is most simple option.)

## Testing the Images from Docker Hub

When you push, github action triggers pushing new docker images to docker hub. To configure this,

1. If you cloned this repo,
    1. On your github repo's Settings, define 2 secrets: REGISTRY_USERNAME and REGISTRY_PASSWORD
    2. Modify `.env-docker-hub` first line, `DOCKER_REGISTRY` to your REGISTRY_USERNAME value.
2. When there is push to github reposotiry, `.github/workflows/docker-image.yml` will push new image to the docker hub using `push-docker-images.sh`.
3. Run `run-docker-hub.sh` to run services using the images from Docker Hub.

## Launching in Kubernetes

1. Install ingress following the instruction from https://kubernetes.github.io/ingress-nginx/deploy/
2. If needed, modify `set-DOCKER_HOST_IP_ADDR.sh` to put the desired hostname for `DOCKER_HOST_NAME` where you want ingress to set up for.
3. Run `run-k8s.sh`
