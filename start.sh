#!/bin/bash

echo "Building image 'pxe'"

docker build -t pxe .

docker run pxe --privileged
