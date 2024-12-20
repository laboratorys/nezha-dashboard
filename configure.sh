#!/bin/bash
run_argo(){
  if [[ -z "${ARGO_TOKEN}" ]];then
    echo "argo配置为空，不执行隧道配置"
  else
    cloudflared service install ${ARGO_TOKEN}
  fi
}
#run_argo
nohup /app/backup2gh &
#sleep 30
nohup /app/dashboard &
nginx -g 'daemon off;'