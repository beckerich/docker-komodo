#!/bin/bash
: ${CONTAINER_NAME:="dockerkomodo_komodod_1"}
docker exec ${CONTAINER_NAME} ./cli "$@"
