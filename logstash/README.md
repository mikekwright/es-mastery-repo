Logstash Tutorial
========================================

So what is Logstash?  Logstash is a data capture and transform tool that can create a pipeline
of data from source to destination.  While we often use logstash to push data to ElasticSearch
it can actually be used for more then just delivering data to ElasticSearch.

Setting up
-----------------------------

For our logstash example we need to specify a few pieces that are required.  These include:

* input
* output

These two sections are used to define what data is coming in, how to read it and also where
the results should be outputted to.

### File Input

Lets start with a simple input that reads from a file for us.

    input {
      file {
        path => "/data/sample.json"
        codec => jsonlines
      }   
    }

We will also add a common output to stdout to see what is happening

    output {
      stdout {
        codec => rubydebug
      }
    }

### Output to ES

    output {
      elasticsearch {
        hosts => [ "elasticsearch:9200" ]
        index => "..."
      }
    }

Lets injest twitter
-----------------------------------

twitter {
    consumer_key => "${CONSUMER_KEY}"
    consumer_secret => "${CONSUMER_SECRET}"
    oauth_token => "${ACCESS_TOKEN}"
    oauth_token_secret => "${ACCESS_TOKEN_SECRET}"
    keywords => ["#100DaysOfCode"]
    full_tweet => false
  }

### Sample Format (not full tweet)

    {
      "@timestamp": "2020-12-04T18:23:15.000Z",
      "@version": "1",
      "client": "<a href=\"https://nlogn.in\" rel=\"nofollow\">Nlogin_re</a>",
      "hashtags": [
        {
          "indices": [ 76, 90 ],
          "text": "100DaysOfCode"
        },
        {
          "indices": [ 91, 102 ],
          "text": "javascript"
        }
      ],
      "message": "... #100DaysOfCode #javascript",
      "retweeted": false,
      "source": "http://twitter.com/...",
      "symbols": [],
      "user": "...",
      "user_mentions": [
        {
          "id": 0000000000,
          "id_str": "0000000000",
          "indices": [ 3, 12 ],
          "name": "Some Name",
          "screen_name": "some_name"
        }
      ]
    }

### Input




How to handle multiple inputs -> different outputs
--------------------------------------

With inputs you can add `tags` which are like labels that can be used to identify those inputs uniquely
and this allows you to specify only certain outputs, if the tags is enabled.

    input {
      ...
    }
    output {
      ...
    }
