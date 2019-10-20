# @debug:
#   docker run --rm -ti --name debug -p 9090:9090 -v yapi:/root/yapi node:8.16.1-jessie bash
#
FROM node:8.16.1-jessie as builder
ARG YAPI_VERSION="1.8.5"
ADD https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz /app/
RUN set -xue \
    && apt-get install -y \
         git \
    && tar -C /app/ -xvf /app/v${YAPI_VERSION}.tar.gz \
    && cd /app/yapi-${YAPI_VERSION}/ \
    && npm install --production --registry https://registry.npm.taobao.org


FROM node:8.16.1-jessie
ENV YAPI_VERSION="1.8.5" \
    YAPI_IMAGE_URL=https://hub.docker.com/r/icmdb/yapi \
    YAPI_IMAGE_MAINTAINER="ihanyouqing@gmail.com" 
RUN     apt-get update && apt-get -y install \
            netcat \
     && apt-get clean all \
     && rm -rf /usr/share/man/* /usr/share/doc/* /var/lib/apt/* /var/log/apt/*.log
COPY --from=builder /app/yapi-${YAPI_VERSION} /app/yapi
COPY docker-entrypoint.sh /app/
COPY          config.json /app/
EXPOSE 3000
WORKDIR /app/
VOLUME  /app/yapi/log/
CMD [ "/app/docker-entrypoint.sh" ]
