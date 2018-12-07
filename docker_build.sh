#!/usr/bin/env bash
if [[ -f ".config" ]]; then
  . .config
else
  . .config.example
fi

docker build -t $IMAGE_NAME:$TAG .
