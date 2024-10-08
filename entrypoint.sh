#!/bin/bash

/usr/sbin/nginx

export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/

# 此处配置需要按照实际情况调整，两个export为新增配置
PY=/home/cesiadmin/miniconda3/envs/ragflow/bin/python
export PYTHONPATH=/data1/code/ragflow
# 可选：添加Hugging Face镜像
export HF_ENDPOINT=https://hf-mirror.com

if [[ -z "$WS" || $WS -lt 1 ]]; then
  WS=1
fi

function task_exe(){
    while [ 1 -eq 1 ];do
      $PY rag/svr/task_executor.py ;
    done
}

for ((i=0;i<WS;i++))
do
  task_exe  &
done

while [ 1 -eq 1 ];do
    $PY api/ragflow_server.py
done

wait;
