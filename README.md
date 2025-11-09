# elk-tls-docker

This docker-compose project will assist with setting up and creating a ELK stack using self-signed TLS certificates.

## Environment Details
This docker-compose project will create the following Elastic containers based on version 7.12.0:

* Elasticsearch
* Logstash
* Kibana

## Setup

In order to use this project, you must first include the following in a file named `.env`. I have provided an example environment variable file here [.env-example](https://github.com/swimlane/elk-tls-docker/blob/master/.env-example).

> Copy or create your own `.env` from the provided example or from the code block below

```text
ELK_VERSION=7.15.0
ELASTIC_USERNAME=elastic
ELASTIC_PASSWORD=some_password

# Configuration Variables
ELASTICSEARCH_HEAP=2g
LOGSTASH_HEAP=1g
XPACK_ENCRYPTION_KEY=somesuperlongstringlikethisoneMQBbtsynu4bV2uxLy

# Self signed TLS certificates
CA_PASSWORD=some_password
CA_DAYS=3650
ELASTIC_DIR=/usr/share/elasticsearch
LOGSTASH_DIR=/usr/share/logstash
KIBANA_DIR=/usr/share/kibana
```

> Note: You may need to change the size of the HEAP variables in the above configuration file based on your system requirements.  The settings present are for a machine with 8GB of memory

**Additionally, you must either clone this repository or download the entire repository in order to build and run these containers.**

### Keystore

Before we build or create our containers we first need to create our keystore and certificates.  You can do this using the [docker-compose.setup.yml](docker-compose.setup.yml) yaml file.

#### Creating Keystore for self-signed certificates

To do so you simply run the following command first:

```bash
docker compose -f docker-compose.setup.yml run --rm certs
```

## Running a development environment

Now, that you have your keys/certs and passwords set we can then just restart the containers by running:

```
docker compose up -d
```

You should be able to login into the ELK stack and be on your way.

## Handy commands

To remove all images from your system run: ```docker rmi $(docker images -a -q)```
To remove all volumes from your system run: ```docker volume prune```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details

