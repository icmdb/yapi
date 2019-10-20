# yapi

* [Docs for English](https://github.com/icmdb/yapi/blob/master/README.md)
* [中文文档](https://github.com/icmdb/yapi/blob/master/README_CN.md)

[YMFE/yapi](https://github.com/YMFE/yapi) is a visualized interface management platform that can be deployed locally, connecting frontend and backend end and QA engineers. https://hellosean1025.github.io/yapi/

This project is created to:

* build image automaticlly
* quick start Yapi (docker or kubernetes)

for [YMFE/yapi](https://github.com/YMFE/yapi). 


## Reference

* [YMFE/yapi - GitHub](https://github.com/YMFE/yapi)
* [YApi Document](https://hellosean1025.github.io/yapi/)  (Chinese only for now)
    * [Yapi deploy locally](https://hellosean1025.github.io/yapi/devops/index.html)
* [mongo - DockerHub](https://hub.docker.com/_/mongo)
* [mongo-express - DockerHub](https://hub.docker.com/_/mongo-express)

## Quick Start

> Install Docker see: [Get Docker Engine](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```bash
# Clone 
git clone https://github.com/icmdb/yapi.git

# Enter yapi directory
cd yapi

# Pull images: yapi,mongo,mongi-express
docker-compose pull

# This may take 30 seconds for yapi-mongo get ready.
docker-compose up -d

# Remove (Carefully)
docker-compose down
rm -rf ./yapidata

# Restart yapi
docker restart yapi
##  or
docker-compose restart yapi
```

Then you can access:

|Name      |URL                    |Memo|
|----------|-----------------------|----|
|Yapi      |http://127.0.0.1:3000  |Sign up with `yapi@icmdb.vip`|
|Mongo     |mongo://127.0.0.1:27017|root / Passw0rd4MongoRoot|
|MongoAdmin|http://127.0.0.1:8081  |yapi / Passw0rd4MongoExpressYapi|

* Details see: 
    * [docker-compose.yml](https://github.com/icmdb/yapi/blob/master/docker-compose.yml)
    * [docker-entrypoint.sh](https://github.com/icmdb/yapi/blob/master/docker-entrypoint.sh)
    * `docker logs yapi` or `docker-compose logs yapi`
* You can change configs in `docker-compose.yml`, then run: `docker-compose up -d` to recreate container.



![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi.jpg)
![Sign up yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-signup.jpg)


## Deploy in kubernetes

```bash
# Set your own domain
YAPI_DOMAIN="domain.com"

git clone git@github.com:icmdb/yapi.git

cd yapi/k8s

grep icmdb.vip -rl ./ | xargs sed -i 's#icmdb.vip#${YAPI_DOMAIN}#g'

kubectl apply -f .
```

## FAQ & Feedback

> Feedback here: [issues](https://github.com/icmdb/yapi/issues)

Try to iterms below if you have problems:

* Check logs by run: `docker logs yapi`.
* Create a database named `yapi` by `yapi-mongo-express` http://127.0.0.1:8081

![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express-login.jpg)
![yapi-mongo-express.jpg](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-mongo-express.jpg)


## Todo List

* [x] README_CN.md
* [x] Backup mongodata
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
