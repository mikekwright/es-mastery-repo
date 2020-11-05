ElasticSearch Mastery Workshop
=======================================

During this workshop we are going to cover the how, where and why the use
of elasticsearch in our team/organization can help us.

For the beginning we are going to give you a scenario, and demonstrate how
we can solve the problem using elasticsearch.  It is important that we point
out that this is just an example, and before deciding on any technology
to be used, you need to have an architectural discussion.

Scenario
---------------------------------

The MIP service is currently a psuedo-stateless service.  There is some state
that is required for label operations to successfully take place.  Since there
is no common store between instances of the service right now, this means that
all instances will need to retrieve their own version of the state. This is not
often a big deal, but it can lead to some issues if any of the following
situations occurs:

* A request for MSFT for state fails on one instance
* One instance's cached state expires and the refresh brings in new labels

For this workshop we are going to go through how we could create a common
store using elasticsearch.  We will start with one scenario, for more uptime
in the UI, we are going to store the list of "last retrieved" labels in
elasticsearch and return them when requested by the UI.

Scenario Steps
-----------------------------------

Below is a list of operations that we are going to run with a description
as to why we are making the selection.

### First

For this workshop lets start by spinning up a cluster (you can run locally
by using docker-compose)

    docker-compose up

### Second

The next thing we need to do is open the kibana tools that we can use to
define our new index to store our data.

[Kibana Dev Tools - http://localhost:8080/app/kibana#/dev_tools/console](http://localhost:8080/app/kibana#/dev_tools/console)  

### Third

We should now be setup to start running some queries against elasticsearch,
lets start by talking about the structure of MIP labels.  They are broken
down into two main parts:

* label name
* label id

There is a "small" hierarchy that also exists, in a parent/child or label/sub-label
configuration.  Currently this is presented to the UI in a flat list, so we
will start by storing the data in a flat list.  We will also need to keep the
list of labels by a given tenant.

Lets first create our `mip` index

    PUT /mip
    {
      "mappings": {
        "properties": {
          "tenant": {
            "type": "text"
          },
          "labels": {
            "type": "nested"
          }
        }
      }
    }

Here we are defining our tenant as a text field, which we can use to store
the tenant ids such as `tenant_<some-id>`, then we can provide a list of
labels that are defined as the current "active" labels for that given tenant.

*TODO:* Fill in details about nested types

### Fourth

We now have our mapping, lets insert a document for a demo tenant. This tenant
will have the following labels:

* `Public` - `3b8c547f-7712-40a5-88e3-91f559757609`
* `Internal` - `c64f5bf8-df73-46bb-b88e-299b5335908b`
* `Documentation` - `afd90184-f1e4-43d1-a745-f9aab27655ef`
* `HR` - `24d48415-8159-4230-bc24-98b72821eaec`

Lets start by constructing the command to insert this demo for tenant
`tenant_1234567890`.

    PUT /mip/_doc/tenant_1234567890
    {
      "tenant": "tenant_1234567890",
      "labels": [
        {
          "name": "Public",
          "id": "3b8c547f-7712-40a5-88e3-91f559757609"
        },
        { "name": "Internal",
          "id": "c64f5bf8-df73-46bb-b88e-299b5335908b"
        },
        {
          "name": "Documentation",
          "id": "afd90184-f1e4-43d1-a745-f9aab27655ef"
        },
        {
          "name": "HR",
          "id": "24d48415-8159-4230-bc24-98b72821eaec"
        }
      ]
    }

We can verify that this data was stored by doing a request to retrieve the
content we just added.

    GET /mip/_doc/tenant_1234567890

### Fifth





