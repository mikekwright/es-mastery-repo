FROM logstash:7.6.0

RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
    mkdir -p /usr/share/logstash/scandata

ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
