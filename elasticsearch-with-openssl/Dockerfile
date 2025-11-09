ARG ELK_VERSION

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELK_VERSION}
USER root
RUN microdnf install -y openssl unzip && microdnf clean all
USER elasticsearch
