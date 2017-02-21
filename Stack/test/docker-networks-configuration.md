docker network create -d overlay --internal INTERCO
docker network create -d overlay FRONT

_________________________________________________
ajouter pour les services backend & middleware : 
=================================================

services:
	networks:
		- INTERCO

networks:
	INTERCO:
		external: true


_________________________________________________
ajouter pour les services frontend : 
=================================================

services:
	networks:
		- INTERCO
		- FRONT


networks:
	INTERCO:
		external: true
	FRONT:
		external: true



#################################################
=================================================
-------------------------------------------------
.................................................

Sources : 

https://technologyconversations.com/2017/01/23/using-docker-stack-and-compose-yaml-files-to-deploy-swarm-services/

https://docs.docker.com/engine/reference/commandline/stack_deploy/

https://docs.docker.com/apidocs/docker-cloud/?http#service

https://stackfiles.io
