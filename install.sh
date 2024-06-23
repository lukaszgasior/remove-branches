#!/bin/bash

set -e

REPO="lukaszgasior/remove-branches"
VERSION="v0.1.0"
PROJECT_NAME="remove-branches"
BIN_NAME="git-remove-branches"

OS=$(uname -s)
ARCH=$(uname -m)

# case $OS in
#     Linux) OS=Linux ;;
#     Darwin) OS=Darwin ;;
#     *) echo "Unsupported OS: $OS" && exit 1 ;;
# esac
#
# case $ARCH in
#     x86_64) ARCH=amd64 ;;
#     arm64) ARCH=arm64 ;;
#     *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
# esac

URL="https://github.com/$REPO/releases/download/$VERSION/${PROJECT_NAME}_${VERSION}_${OS}_${ARCH}.tar.gz"

echo "Downloading $URL"
curl -L -o ${PROJECT_NAME}.tar.gz $URL

echo "Extracting ${PROJECT_NAME}.tar.gz"
tar -xzf ${PROJECT_NAME}.tar.gz

echo "Installing ${BIN_NAME} to /usr/local/bin"
chmod +x ${BIN_NAME}
sudo mv ${BIN_NAME} /usr/local/bin/

echo "Cleaning up"
rm ${PROJECT_NAME}.tar.gz

echo "Installation complete"

