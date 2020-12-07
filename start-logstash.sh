#!/usr/bin/env bash

COMPOSE_FILE=docker-compose.logstash.yml

cd "$(dirname $0)"

./logstash/create.sh && \
  docker-compose -f ${COMPOSE_FILE} build && \
  docker-compose -f ${COMPOSE_FILE} up

