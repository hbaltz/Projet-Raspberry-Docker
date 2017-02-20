#!/bin/bash

# Ajouter un Noeud/Node
sudo gluster peer probe 172.31.57.63
sudo gluster peer probe 172.31.57.70
sudo gluster peer probe 172.31.57.69
sudo gluster peer probe 172.31.57.62
sudo gluster peer probe 172.31.57.68
sudo gluster peer probe 172.31.56.159
sudo gluster peer probe 172.31.57.66
sudo gluster peer probe 172.31.57.156
sudo gluster peer probe 172.31.56.157
sudo gluster peer probe 172.31.56.158

# Creer un nouveau volume avec mode replication
sudo gluster volume create gfsdata replica 3 transport tcp\
        172.31.57.64:/data\
        172.31.57.63:/data\
        172.31.57.70:/data\
        172.31.57.69:/data\
        172.31.57.62:/data\
        172.31.57.68:/data\
        172.31.56.159:/data\
        172.31.57.66:/data\
        172.31.57.156:/data\
        172.31.56.157:/data\
        172.31.56.158:/data\
	172.31.56.158:/data2\
        force

# Ensuite demarrer votre volume/repertoire :
sudo gluster volume start gfsdata

# Afficher le status des connexions en cours :
sudo gluster peer status
# Afficher les infos des volumes :
sudo gluster volume info

exit
