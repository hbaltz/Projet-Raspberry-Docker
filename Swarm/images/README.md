# Swarm tutorial

After a swarm initialisation, we can see :
![docker info ](03-docker_info.png)

This is our manager !

Then, we have to generate the token to join our swarm.
- generate token as manager
![docker_swarm_manager_token](04-docker_swarm_manager_token.png)

- generate token as worker
![docker_swarm_worker](05-docker_swarm_worker.png)

Once we have the token, we could add a node by joining the swarm :
![join a swarm](06-joinASwarmAsWorker.png)

Now, we can see our new node is well a worker (because it is not a manager) :
![docker info ](07-infoWorkerSwarm.png)

Here is the list of all the nodes. We can see our manager (piensg009) and the worker we added (piensg018) :
![docker nodes ](08-docker_node_ls.png)
> This information is accessible from manager only.
Exemple from a worker : ![docker nodes access denied](09-nodelsSwarmNotAccess.png)

Then we can create a new service on our swarm :
![docker create service ](10-docker_service_create.png)

and check which services are running :
![docker service ls ](11-docker_service_ls.png)

To read more details about this service, we can inspect it :
![docker service inspect ](12-docker_service_inspect.png)

We can also see on which node this service is running :
![docker service ps ](13-docker_service_ps.png)

If we start a webserver (port 80) on the swarm, we can access to it on the browser, like this [httpd docker image](https://github.com/hypriot/rpi-busybox-httpd) :

![docker webservice ](14-httpd-swarm.png)
