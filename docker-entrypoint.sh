#!/bin/bash

set -eo pipefail
shopt -s nullglob


YAPI_DEBUG="${YAPI_DEBUG:=}"
YAPI_DELAY="${YAPI_DELAY:=3}"

YAPI_PORT="${YAPI_PORT:=3000}"
YAPI_ACOUNT="${YAPI_ACOUNT:=help@icmdb.vip}"
YAPI_DB_HOST="${YAPI_DB_HOST:=mongo.loc.icmdb.vip}"
YAPI_DB_NAME="${YAPI_DB_NAME:=yapi}"
YAPI_DB_PORT="${YAPI_DB_PORT:=27017}"
YAPI_USER="${YAPI_USER:=root}"
YAPI_PASS="${YAPI_PASS:=YapiMongoPassw0rd}"
YAPI_AUTH="${YAPI_AUTH:=admin}"

YAPI_MAIL_ENABLE="${YAPI_MAIL_ENABLE:=true}"
YAPI_MAIL_HOST="${YAPI_MAIL_HOST:=smtpdm.aliyun.com}"
YAPI_MAIL_PORT="${YAPI_MAIL_PORT:=465}"
YAPI_MAIL_FROM="${YAPI_MAIL_FROM:=notice@mail.icmdb.vip}"
YAPI_MAIL_USER="${YAPI_MAIL_USER:=${YAPI_MAIL_FROM}}"
YAPI_MAIL_PASS="${YAPI_MAIL_PASS:=YapiMailPassw0rd}"


[ "${YAPI_DEBUG}" == 1 ] && set -xe
if [ ! -z "${YAPI_DELAY}" ]; then
    echo ""
    echo "Yapi will start in ${YAPI_DELAY} seconds..."
    echo ""
    sleep ${YAPI_DELAY}
fi

yapi_db_config() {
    for envar in YAPI_ACOUNT YAPI_DB_HOST YAPI_DB_NAME YAPI_DB_PORT YAPI_DB_USER YAPI_DB_PASS YAPI_DB_AUTH
    do
        local holder=$(eval echo '$'${envar})
        sed -i "s#"${envar}"#"${holder}"#g"   /app/config.json
    done
    sed -i       "s#YAPI_PORT#${YAPI_PORT}#g" /app/config.json
    sed -i "s#YAPI_DB_PORT#${YAPI_DB_PORT}#g" /app/config.json
}

yapi_mail_config(){
    local holder
    if [ "${YAPI_MAIL_ENABLE}" == "true" ]; then
        for envar in YAPI_MAIL_ENABLE YAPI_MAIL_HOST YAPI_MAIL_FROM YAPI_MAIL_USER YAPI_MAIL_PASS
        do
            local holder=$(eval echo '$'${envar})
            sed -i "s#"${envar}"#"${holder}"#g"       /app/config.json
        done
        sed -i "s#YAPI_MAIL_PORT#${YAPI_MAIL_PORT}#g" /app/config.json
    fi
}

yapi_db_config
yapi_mail_config

exec node /app/yapi/server/app.js "${@}"
