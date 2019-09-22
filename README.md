# yapi

A project used to build a docker image for YMFE/yapi.

## Reference

* [YMFE/yapi - GitHub](https://github.com/YMFE/yapi)
* [mongo - DockerHub](https://hub.docker.com/_/mongo)
* [mongo-express - DockerHub](https://hub.docker.com/_/mongo-express)

## Quick Start

> Details See: [docker-compose.yml](./docker-compose.yml)

* Start `yapi`, `mongo`, `mongo-express`:

```bash
git clone git@github.com:icmdb/yapi.git

cd yapi

docker-compose pull

# This may take 30 seconds unitl yapi-mongo get ready.
docker-compose up -d
```

* Create a database named `yapi` by `yapi-mongo-express` http://127.0.0.1:8081 

![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express-1.jpg)
![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express-2.jpg)


> Then enjoy it:

* yapi: http://127.0.0.1:3000

> Try to restart `yapi` if you have problems:

```bash
docker restart yapi

# or

docker-compose restart yapi
```
