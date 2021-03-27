# vertical-slice

A prototype for linux development on WSL.

## Goals

1. Be able to develop full stack with debug and watch capability with VSCode DevContainer.
2. Produce configurable containers for deployment.

## Preparation

Tested on Windows 10 20H2 OS Build 19042.867.

1. Install WSL 2, Ubuntu and Windows Terminal (optional).
2. Clone the repo on WSL 2 filesystem.
3. On WSL, run `launch-dev.sh` to start VS Code, then click Reopen in Container on each VS Code.
4. On each VS Code, F5 to launch the app.
    - vue-app runs in watch mode. Any changes are HMRed.
    - web-api runs in debug mode. You can put breakpoint in VS Code.
    - To run web-api in watch mode, you have to stop the debug, and run `dotnet watch run src/web-api` on the terminal.
5. Make changes.
6. Run `docker-build.sh` to build docker images.
7. Run `docker-dev-run.sh` to instantiate docker containers in dev mode.
    - dev mode in web-api does not redirect http to https.
8. Do git commit/push in WSL console. (That is most simple option.)