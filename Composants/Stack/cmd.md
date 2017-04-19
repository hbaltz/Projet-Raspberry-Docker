# Some commands for stack manipulation

## Get a definition file
```
curl -L https://raw.githubusercontent.com/hbaltz/Projet-Raspberry-Docker/master/Composants/Stack/prod/V1/docker-config-registry.yml > docker-config-registry.yml
```

## Deploy
```
docker stack deploy -c docker-config-registry NAME_STACK
```

## List stacks
```
docker stack ls
```

## List the tasks in the stack
```
docker stack ps NAME_STACK
```

## List the services in the stack
```
docker stack services NAME_STACK
```

## Remove the stack
```
docker stack rm NAME_STACK
```
