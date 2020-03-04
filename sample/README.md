Shakespeare Sample
=============================================

## Source

The sample data for Shakespeare was found at the elasticsearch site - https://www.elastic.co/guide/en/kibana/6.8/tutorial-load-dataset.html  

## Mappings

    "mappings" : {
      "properties" : {
        "speaker" : {"type": "keyword" },
        "play_name" : {"type": "keyword" },
        "line_id" : { "type" : "integer" },
        "speech_number" : { "type" : "integer" }
      }
    }

## Installing

There is a simple script setup to install the mappings and the data, you can accomplish this
by running the below command:

    ./install-shakespeare.sh

This is basically running the following two commands:

```bash
# First upload the mappings
curl -H "Content-Type: application/json" -XPUT "${ES_HOST}/shakespeare" --data-binary @shakespeare-mapping.json

# Now upload the data (this will take a while)
curl -H "Content-Type: application/json" -XPUT "${ES_HOST}/shakespeare/_bulk" --data-binary @shakespeare-data.json
```

## Querying

To view the content, you can run a couple of curl commands:

```bash

# Query the top 5 results from the index (jq for pretty formatting)
curl -H "Content-Type: application/json" -XGET "http://localhost:9200/shakespeare/_search"  | jq

# Pass in the query specific details
curl -H "Content-Type: application/json" -XGET "http://localhost:9200/shakespeare/_search" -d '
{
  "query": {
    "match_all": {}
  }
}' | jq

```

## Kibana

Using `Dev Tools` you can query the shakespeare index:

    GET shakespeare/_search
    {
      "query": {
        "match_all": {}
      }
    }

For discovery you will want to create an index pattern at *Management* > *Index Patterns* > *Create index pattern*  

