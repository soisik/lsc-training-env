# LSC training environment

Run two OpenLDAP directory based on LTB packages:

* Source (port: 1389, rootDN: cn=Manager,dc=lsc,dc=src pwd: secret)
   * dc=lsc,dc=src
	    * ou=groups
			   * cn=group1
				 * ...
			* ou=users
			   * uid=xxx
				 * ...
* Dest (port: 2389, rootDN: cn=Manager,dc=lsc,dc=dst pwd: secret)
   * dc=lsc,dc=src
	    * ou=groups
	    * ou=users

Build image :

```
docker build . -t lsc-training
````

Run container :

```
docker run -dit --name my-lsc-training -p 1389:1389 -p 2389:2389 lsc-training:latest
```

Open a bash shell in container :

```
docker exec -i -t my-lsc-training /bin/bash
```

Get container IP address :

```
docker inspect --format '{{ .NetworkSettings.IPAddress }}' my-lsc-training
```
