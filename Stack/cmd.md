# CMD

## Copy definition file 
```
curl -L https://raw.githubusercontent.com/hbaltz/Projet-Raspberry-Docker/master/Stack/docker-config.yml > docker-config.yml

```

## Deploy
```
docker stack deploy -c docker-config.yml NAME_STACK
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

## Remove
```
docker stack rm NAME_STACK
```