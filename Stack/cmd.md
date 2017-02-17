# CMD

## Copy definition file 
```
curl -L https://raw.githubusercontent.com/hbaltz/Projet-Raspberry-Docker/master/Stack/docker-config.yml > docker-config.yml

```

## Deploy
```
docker stack deploy -c docker-config.yml NOM_STACK
```