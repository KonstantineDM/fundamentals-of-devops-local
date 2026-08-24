#!/usr/bin/env bash

set -e

name=$(bun -e "console.log(require('./package.json').name)" | tr -d '"')
version=$(bun -e "console.log(require('./package.json').version)" | tr -d '"')

docker buildx build \
    --platform=linux/amd64,linux/arm64 \
    --load \
    -t "$name:$version" \
    .