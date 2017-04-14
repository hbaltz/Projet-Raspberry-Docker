## Tuto create swarm
https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/


## Initialize a cluster
```
docker swarm init --advertise-addr 172.31.57.68
```

```
To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-44wohi5nqje7f3jpefgc456fl5q3kpintj5ysdjll6cxe5v05g-49j07oce8r5l5wtgeq4hdqmfk \
    172.31.57.68:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

## List the nodes
```
docker node ls
```

## Create the command line to join the cluster as a worker
```
docker swarm join-token worker
```
> For our study case, please use the commands written in [commands.md](commands.md).

## Create the command line to join the cluster as a manager
```
docker swarm join-token manager
```
> For our study case, please use the commands written in [commands.md](commands.md).


## Deploy a service
```
docker service create --replicas 1 --name helloworld alpine ping docker.com
```


* The docker service create command creates the service.
* The --name flag names the service helloworld.
* The --replicas flag specifies the desired state of 1 running instance.
* The arguments alpine ping docker.com define the service as an Alpine Linux container that executes the command ping docker.com.

## Scale a service
```
docker service scale NAME_SERVICE=NB_SCALE
```

## List the running services
```
docker service ls
```

## Inspect a service
```
docker service inspect helloworld

OR

docker service inspect --pretty helloworld
```

## See which nodes are running a service
```
docker service ps helloworld
```

## remove a service
```
docker service rm helloworld
```

## Delete a node in the list when a node leave the cluster
```
docker node rm ID_NODE  
docker node rm --force ID_NODE
```

## Promote nodes
```
docker node promote [IDS_NODES]
```

## Demote nodes
```
Demote node promote [IDS_NODES]
```

# Launch a httpd service
```
docker service create --replicas 1 --name httpd -p 8080:80 hypriot/rpi-busybox-httpd
```

# Update the port used by a service
```
docker service update --publish-rm 8080 httpd
docker service update --publish-add 8081:80 httpd
```
