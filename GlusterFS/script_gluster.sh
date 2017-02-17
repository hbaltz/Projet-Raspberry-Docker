#!/bin/bash

sudo gluster volume create Data replica 11 transport tcp\
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
        force

sudo gluster volume start Data
sudo gluster volume info

sudo gluster peer probe 172.31.57.64 force --mode=script
sudo gluster peer probe 172.31.57.63 force --mode=script
sudo gluster peer probe 172.31.57.70 force --mode=script
sudo gluster peer probe 172.31.57.69 force --mode=script
sudo gluster peer probe 172.31.57.62 force --mode=script
sudo gluster peer probe 172.31.57.68 force --mode=script
sudo gluster peer probe 172.31.56.159 force --mode=script
sudo gluster peer probe 172.31.57.66 force --mode=script
sudo gluster peer probe 172.31.57.156 force --mode=script
sudo gluster peer probe 172.31.56.157 force --mode=script
sudo gluster peer probe 172.31.56.158 force --mode=script

exit
