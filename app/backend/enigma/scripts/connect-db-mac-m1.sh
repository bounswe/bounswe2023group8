#!/bin/bash

# shellcheck disable=SC2046
export $(xargs <../.env)

if [ ! -f cloud-sql-proxy ]; then
    curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.7.1/cloud-sql-proxy.darwin.arm64
    chmod +x cloud-sql-proxy
fi
echo ./cloud-sql-proxy web-info-aggregator:europe-west6:punchcard --credentials-file=$MYSQL_CREDENTIALS_PATH --port=3307
./cloud-sql-proxy web-info-aggregator:europe-west6:punchcard --credentials-file=$MYSQL_CREDENTIALS_PATH --port=3307
