#!/bin/bash -e

echo "Building image 'pxe'"

docker build -t pxe .

docker run --privileged pxe
