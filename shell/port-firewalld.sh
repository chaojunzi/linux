#!/bin/bash
#开启防火墙
PORT_PATTERN="^[0-9]{2,5}([-]{1}[0-9]{2,5})?$"
if [[ ! "$1" =~ $PORT_PATTERN ]];then
   echo "端口异常：$1"
   exit 0;
fi

CMD_PATTERN="^((add)|(remove)){1}$"

if [[ ! "$2" =~ $CMD_PATTERN ]];then
    echo "请输入指令：add Or remove"
    exit 0;
fi

sudo firewall-cmd --permanent --$2-port=$1/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all