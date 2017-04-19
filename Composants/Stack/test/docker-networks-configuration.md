# Notes sur les liens entre les réseaux

```
docker network create -d overlay --internal DATA
docker network create -d overlay INTERCO
docker network create -d bridge FRONT
```
### ajouter pour les services backend :
```
services:
	networks:
		- DATA

networks:
	DATA:
		external: true
```

### ajouter pour les services middleware :
```
services:
	networks:
		- INTERCO
		- DATA

networks:
	INTERCO:
		external: true
	DATA:
		external: true
```

### ajouter pour les services frontend :
```
services:
	networks:
		- INTERCO
		- FRONT

networks:
	INTERCO:
		external: true
	FRONT:
		external: true
```


## Bibliographie :
- https://technologyconversations.com/2017/01/23/using-docker-stack-and-compose-yaml-files-to-deploy-swarm-services/
- https://docs.docker.com/engine/reference/commandline/stack_deploy/
- https://docs.docker.com/apidocs/docker-cloud/?http#service
- https://stackfiles.io
