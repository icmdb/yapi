# @debug:
#   docker run --rm -ti --name debug -p 3000:3000-v $(pwd):/app/yapi node:8.16.1-jessie bash
#
FROM node:8.16.1-jessie as builder
ARG YAPI_VERSION="1.8.5"
ARG NPM_REGISTRY="https://registry.npmjs.org/"
ADD https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz /app/
RUN set -xue \
    && apt-get install -y \
         git \
    && tar -C /app/ -xvf /app/v${YAPI_VERSION}.tar.gz \
    && cd /app/yapi-${YAPI_VERSION}/ \
    && npm install --production --registry ${NPM_REGISTRY}


FROM node:8.16.1-jessie
ARG NPM_REGISTRY="https://registry.npmjs.org/"
ENV YAPI_VERSION="1.8.5" \
    YAPI_SOURCE_URL=https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz  \
    YAPI_IMAGE_URL=https://hub.docker.com/r/icmdb/yapi \
    YAPI_IMAGE_MAINTAINER="ihanyouqing@gmail.com" 
COPY --from=builder /app/yapi-${YAPI_VERSION} /app/yapi
COPY docker-entrypoint.sh /app/
COPY          config.json /app/
WORKDIR /app/
RUN     npm install -g yapi-cli --registry https://registry.npm.taobao.org \
     && apt-get update && apt-get -y install \
            netcat \
     && apt-get clean all \
     && rm -rf /usr/share/man/* /usr/share/doc/* /var/lib/apt/* /var/log/apt/*.log ~/.npm/
EXPOSE 3000
VOLUME  /app/yapi/log/
CMD [ "/app/docker-entrypoint.sh" ]
