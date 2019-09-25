# yapi

A project used to build a docker image for YMFE/yapi.

* [Docs for English]()
* [中文文档](README_CN.md)

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
> Then enjoy it:

* yapi: http://127.0.0.1:3000

> Try to iterms below if you have problems:

* Create a database named `yapi` by `yapi-mongo-express` http://127.0.0.1:8081 with **default username/password**: _admin/YapiMongoExpressPassw0rd_ , details see [docker-compose.yml](docker-compose.yml).

![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express-1.jpg)
![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express-2.jpg)

* Restart `yapi` :

```bash
docker restart yapi

# or

docker-compose restart yapi
```

## Deploy in kubernetes

```bash
YAPI_DOMAIN="domain.com"    # your domain

git clone git@github.com:icmdb/yapi.git

cd yapi/k8s

grep icmdb.vip -rl ./ | xargs sed -i 's#icmdb.vip#${YAPI_DOMAIN}#g'

kubectl apply -f .
```


## Todo List

* [ ] README_CN.md
* [x] Yaml for k8s
* [ ] Helm Charts
* [ ] Plugins
    * [ ] sso
    * [ ] cas
    * [ ] oauth2.0
    * [ ] rap
    * [ ] dingding
    * [ ] export-docx-data
    * [ ] interface-oauth-token
    * [ ] import-swagger-customize
