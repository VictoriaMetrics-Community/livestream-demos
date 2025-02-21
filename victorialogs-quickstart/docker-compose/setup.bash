#!/bin/bash
git clone https://github.com/VictoriaMetrics/victoriaMetrics
cd victoriametrics/deplyment/docker
docker compose up -d -f docker-compose-victorialogs.yml
