# yapi

* [Docs for English](https://github.com/icmdb/yapi/blob/master/README.md)
* [中文文档](https://github.com/icmdb/yapi/blob/master/README_CN.md)

[YMFE/yapi](https://github.com/YMFE/yapi) 是一个可本地部署的、打通前后端及QA的、可视化的接口管理平台.

本项目用于为：

* 自动构建docker镜像
* 快速部署 [YMFE/yapi](https://github.com/YMFE/yapi)（使用 docker-compose 或 kubernetes）


## Reference

* [YMFE/yapi - GitHub](https://github.com/YMFE/yapi)
* [YApi Document](https://hellosean1025.github.io/yapi/) 
    * [Yapi deploy locally](https://hellosean1025.github.io/yapi/devops/index.html)
* [mongo - DockerHub](https://hub.docker.com/_/mongo)
* [mongo-express - DockerHub](https://hub.docker.com/_/mongo-express)

## Quick Start

> 安装Docker: [Get Docker Engine](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

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

访问地址:

|Name      |URL                    |Memo|
|----------|-----------------------|----|
|Yapi      |http://127.0.0.1:3000  |使用`yapi@icmdb.vip`注册,(可在[docker-compose.yaml](https://github.com/icmdb/yapi/blob/master/docker-compose.yml)中修改)|
|Mongo     |mongo://127.0.0.1:27017|root / Passw0rd4MongoRoot|
|MongoAdmin|http://127.0.0.1:8081  |yapi / Passw0rd4MongoExpressYapi|

![Create database yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi.jpg)
![Sign up yapi](https://raw.githubusercontent.com/icmdb/yapi/master/images/yapi-signup.jpg)


* Details see: 
    * [docker-compose.yml](https://github.com/icmdb/yapi/blob/master/docker-compose.yml)
    * `docker logs yapi` or `docker-compose logs yapi`

可修改 [docker-compose.yml](https://github.com/icmdb/yapi/blob/master/docker-compose.yml)变更默认配置, 然后执行 `docker-compose up -d` 命令重建容器.


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

> 意见反馈: [issues](https://github.com/icmdb/yapi/issues)

如果遇到问题可以尝试:

* 查看日志：`docker logs yapi`

* 使用 `yapi-mongo-express` 创建库 `yapi`： http://127.0.0.1:8081

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
