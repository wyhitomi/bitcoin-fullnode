#!/usr/bin/env bash
if [[ -f ".config" ]]; then
  . .config
else
  . .config.example
fi

docker push $IMAGE_NAME:$TAG
