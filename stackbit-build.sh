#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5dbc04f3dd7fd5001a20394d/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5dbc04f3dd7fd5001a20394d 
fi
curl -s -X POST https://api.stackbit.com/project/5dbc04f3dd7fd5001a20394d/webhook/build/ssgbuild > /dev/null
gatsby build

curl -s -X POST https://api.stackbit.com/project/5dbc04f3dd7fd5001a20394d/webhook/build/publish > /dev/null
