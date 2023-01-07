# Flux testing environment for PSI/J

## Build docker container

```shell
./psij/flux/docker/build.sh
```

## Start execution

```shell
docker run --rm -it exaworks/flux-psij bash

flux start
python3.7 /home/fluxuser/workdir/hello-flux-container.py
```

## Start execution using `docker compose` (multi-broker)

```shell
cd psij/flux/docker

docker compose up -d
# stop containers (flux-psij and flux-sched)
#   docker compose stop
# remove containers
#   docker compose rm -f

docker exec -it flux-psij bash

# start with 2 brokers (services in docker-compose)
# NOTE: FLUX_CONF_DIR is an alternative way to provide a config directory
flux start -o,--config-path=/home/fluxuser,-Sbroker.quorum-timeout=2s
# check list of resources
#   flux resource list
python3.7 /home/fluxuser/workdir/hello-flux-container.py
```
