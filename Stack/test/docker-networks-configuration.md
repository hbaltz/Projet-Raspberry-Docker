docker network create -d overlay --internal DATA
docker network create -d overlay INTERCO

_________________________________________________
ajouter pour les services backend :
=================================================

services:
	networks:
		- DATA

networks:
	DATA:
		external: true

_________________________________________________
ajouter pour les services middleware :
=================================================

services:
	networks:
		- INTERCO
		- DATA

networks:
	INTERCO:
		external: true
	DATA:
		external: true


_________________________________________________
ajouter pour les services frontend :
=================================================

services:
	networks:
		- INTERCO

networks:
	INTERCO:
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
