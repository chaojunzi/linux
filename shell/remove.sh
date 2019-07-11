#!/bin/bash
trash_dir=/tmp/trash/`date +%Y%m%d`      #自己创建的文件夹的路径
if [ ! -d ${trash_dir} ] ;then
    mkdir -p ${trash_dir}
fi

for i in $*
do
    #result=$(echo $1 | egrep '^/(\*)?');
    suffix=`date "+%H%M%S"`
    if [ ${i} == "/" ]|| [ ! -d "${i}" ]&&[ ! -f "${i}" ];then    #首先判断是否是合法的文件或者文件夹
        if [ "${i}" != "-rf" ];then     #这里对-rf进行处理，因为mv指令后面没有-rf参数
         #  echo "[${i}] do not exist"
	echo -e "\033[1m[${i}] \033[31m do not exist \033[0m！"
        fi
    else
        file_name=`basename $i`   #取得文件名称  
        mv ${i} ${trash_dir}/${file_name}_${suffix}_${RANDOM} 
        #echo "[${i}] delete completed"
	echo -e "\033[1m[${i}] \033[31mdelete \033[32mcompleted\033[0m！"  
    fi
done
