# @debug:
#   docker run --rm -ti --name debug -p 9090:9090 -v yapi:/root/yapi node:8.16.1-jessie bash
#
FROM node:8.16.1-jessie as builder
ADD https://github.com/YMFE/yapi/archive/v1.8.3.tar.gz /app/
RUN set -xue \
    && apt-get install -y \
         git \
    && tar -C /app/ -xvf /app/v1.8.3.tar.gz \
    && mv /app/yapi-1.8.3 /app//yapi \
    && cd /app/yapi/ \
    && npm install --production --registry https://registry.npm.taobao.org


FROM node:8.16.1-jessie
COPY --from=builder /app/yapi /app/yapi
COPY docker-entrypoint.sh     /app/
COPY          config.json     /app/
EXPOSE 3000
WORKDIR /app/
VOLUME /app/yapi/log/
CMD [ "/app/docker-entrypoint.sh" ]
