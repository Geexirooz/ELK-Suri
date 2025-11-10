# ELK-Suri
This docker-compose project will assist with setting up and creating a ELK stack (with no L for now) using self-signed TLS certificates.
This repo's idea comes from [this](https://github.com/swimlane/elk-tls-docker/tree/master) great repository

## Environment Details
This docker-compose project will create the following Elastic containers based on version 9.2.0:

* Elasticsearch
* Kibana

## Setup

In order to use this project, you must first include the following in a file named `.env`. I have provided an example environment variable file here [.env-example](https://github.com/swimlane/elk-tls-docker/blob/master/.env-example).

> Copy or create your own `.env` from the provided example or from the code block below

```text
ELK_VERSION=9.2.0

# Credentials
KIBANA_USERNAME=kibana_geexi
KIBANA_PASSWORD=some_password_for_kibana
SUPERUSER_USERNAME=geexirooz
SUPERUSER_PASSWORD=some_other_password

# URLs
KIBANA_URL=https://0.0.0.0:5601

# Configuration Variables
ELASTICSEARCH_HEAP=2g
XPACK_ENCRYPTION_KEY=somesuperlongstringlikethisoneMQBbtsynu4bV2uxLy

# Self signed TLS certificates
CA_DAYS=3650
ELASTIC_DIR=/usr/share/elasticsearch
KIBANA_DIR=/usr/share/kibana

# Suricata Configuration
SURICATA_VERSION=8.0.2
INTERFACE=eth0
SURICATA_DIR=/etc/suricata
SURICATA_RULES_SOURCES="all"
#SURICATA_RULES_SOURCES="et/open oisf/trafficid abuse.ch/sslbl-blacklist abuse.ch/sslbl-ja3 abuse.ch/feodotracker abuse.ch/urlhaus etnetera/aggressive tgreen/hunting stamus/lateral pawpatrules ptrules/open aleksibovellan/nmap"
```

> Note: You may need to change the size of the HEAP variables in the above configuration file based on your system requirements.  The settings present are for a machine with 8GB of memory

**Additionally, you must either clone this repository or download the entire repository in order to build and run these containers.**

### Keystore, Certificates and Users Credentials

Before we build or create our containers we first need to create our keystore, certificates and the users.  You can do this using the [docker-compose.setup.yml](docker-compose.setup.yml) yaml file.

To do so you simply run the following command first:

```bash
docker compose -f docker-compose.setup.yml run --rm certs
```

## Running a development environment

Now, that you have your keys/certs and passwords set we can then just spin up the containers by running:

```
docker compose up -d
```

You should be able to login into the ELK stack with `SUPERUSER_USERNAME` user from your `.env` file.

## Handy commands

To remove all images from your system run: ```docker rmi $(docker images -a -q)```

To remove all volumes from your system run: ```docker volume prune```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details

