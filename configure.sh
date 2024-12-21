#!/bin/bash
nohup /app/backup2gh &
sleep 30
nohup /app/dashboard &
nginx -g 'daemon off;'