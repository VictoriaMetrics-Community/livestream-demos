#!/bin/env bash
if [ ! -d "victoriaMetrics" ]; then
  git clone https://github.com/VictoriaMetrics/victoriaMetrics
fi
cd victoriaMetrics/deployment/docker
rm -f docker-compose.yml
ln -s docker-compose-victorialogs.yml docker-compose.yml
docker compose up -d
