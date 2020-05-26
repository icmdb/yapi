# @debug:
#   docker run --rm -ti --name debug -p 3000:3000-v $(pwd):/app/yapi node:8.16.1-jessie bash
#
ARG YAPI_BASE_IMAGE="node:8.16.1-jessie"
ARG YAPI_VERSION="1.9.1"
ARG NPM_REGISTRY="https://registry.npmjs.org/"
ARG YAPI_DIR="/app/yapi"

FROM ${YAPI_BASE_IMAGE} as builder
ARG YAPI_VERSION
ARG YAPI_DIR
ARG NPM_REGISTRY
ADD https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz ${YAPI_DIR}/
RUN set -xue \
    && apt-get install -y \
         git \
    && tar -C ${YAPI_DIR}/ -xvf /${YAPI_DIR}/v${YAPI_VERSION}.tar.gz \
    && cd ${YAPI_DIR}/yapi-${YAPI_VERSION}/ \
    && npm install --production --registry ${NPM_REGISTRY}


FROM ${YAPI_BASE_IMAGE}
ARG YAPI_VERSION
ARG YAPI_DIR
ARG NPM_REGISTRY
ENV YAPI_DIR=${YAPI_DIR} \
    YAPI_VERSION=${YAPI_VERSION} \
    YAPI_SOURCE_URL=https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz  \
    YAPI_IMAGE_URL=https://hub.docker.com/r/icmdb/yapi \
    YAPI_IMAGE_MAINTAINER="ihanyouqing@gmail.com" 
COPY --from=builder ${YAPI_DIR}/yapi-${YAPI_VERSION} ${YAPI_DIR}
COPY docker-entrypoint.sh /app/
COPY          config.json /app/
WORKDIR ${YAPI_DIR}
RUN     npm install -g yapi-cli --registry ${NPM_REGISTRY} \
     && apt-get update && apt-get -y install \
            netcat \
            apt-utils \
     && apt-get clean all \
     && rm -rf /usr/share/man/* /usr/share/doc/* /var/lib/apt/* /var/log/apt/*.log ~/.npm/
EXPOSE 3000
VOLUME  ${YAPI_DIR}/log/
CMD [ "/app/docker-entrypoint.sh" ]
