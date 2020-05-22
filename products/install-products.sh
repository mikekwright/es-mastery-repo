#!/usr/bin/env bash
#vim :set filetype=sh:

ES_HOST=${ES_HOST:-http://localhost:9200}

# Make sure we are in the current directory
cd "$(dirname $0)"

# Now upload the data (this will take a while)
curl -H "Content-Type: application/json" -XPUT "${ES_HOST}/products/_bulk" --data-binary @products-bulk.json

