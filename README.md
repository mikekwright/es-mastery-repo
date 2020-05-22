Elasticsearch Mastery Repo
=============================================

Repo holding findings and efforts around becoming an elasticsearch expert.

## Starting

This solution uses `docker-compose` so to spin up the single node cluster with kibana run the following.

    docker-compose up

    # For background starting
    docker-compose start

Once you are down you can either stop using `ctrl+c` or `docker-compose stop`.  This does not free up the
volume resources, to accomplish that you will want to run the following.

    docker-compose down

    # Be sure to delete the volumes
    docker-compose down -v

