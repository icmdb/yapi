#!/bin/bash
#

backupdir="./backup"
mongodata="./yapi-mongodata"
timestamp="$(date +%s)"

[ -d "${backupdir}" ] || mkdir -pv ${backupdir}

echo -e "\n==> [$(date '+%F %T%z')] Stopping yapi-mongo...\n"
docker stop yapi-mongo

[ -d "${mongodata}" ] || echo "==> [$(date '+%F %T%z')] ${mongodata} not exists."

echo -e "\n==> [$(date '+%F %T%z')] Backuping yapi-mongo...\n"
tar -czvf ${backupdir}/yapi-mongodata.${timestamp}.tgz ./${mongodata}

echo -e "\n==> [$(date '+%F %T%z')] Backup completed to \"${backupdir}/yapi-mongodata.${timestamp}.tgz\".\n"

