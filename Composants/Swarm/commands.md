Connecter un worker au swarm :

    docker swarm join --token SWMTKN-1-44wohi5nqje7f3jpefgc456fl5q3kpintj5ysdjll6cxe5v05g-49j07oce8r5l5wtgeq4hdqmfk 172.31.57.68:2377

Connecter un manager au swarm :

    docker swarm join --token SWMTKN-1-44wohi5nqje7f3jpefgc456fl5q3kpintj5ysdjll6cxe5v05g-7mcsym7affqug4on1g8vzzkpo 172.31.57.68:2377


Vérifier le status du worker :

    docker info
