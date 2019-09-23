#!/bin/bash
#0.------>项目前缀
root_path=$(cd "$(dirname "$0")";pwd)
cd $root_path/../conf
AppName="`grep app.name application.properties | cut -d'=' -f2 | sed 's/\r//'`";
#1.------>配置文件目录
CONF_OPTS="-Dspring.config.location=classpath:/,classpath:/config/,file:./,file:./config/,file:../config/$2/"

NACOS_OPTS="-Duser.home=/tmp -Dspring.cloud.nacos.config.server-addr=127.0.0.1:8848   -Dspring.cloud.nacos.config.namespace=0e8b6430-57b6-497a-a8b5-ce77bed45ac3"

JAVA_OPTS="-server -Xms512m -Xmx512m -Xmn200m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -Xverify:none -XX:+DisableExplicitGC -Djava.awt.headless=true -Duser.home=/tmp  -Djava.io.tmpdir=/var/tmp $CONF_OPTS $NACOS_OPTS"
#SpringBoot=$2
SpringBoot=
 
echo $1 $2
 
if [ "$1" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi
#2.----->jar包文件目录
cd $root_path/../server
SpringBoot="`pwd`/${AppName}-$2.jar";

SpringBoots=`ls ${SpringBoot}`
if [ "$SpringBoots" = "" ];
then
    echo -e "\033[0;31m 文件中没有对应的应用 \033[0m"
    exit 1
fi

#for sb in $SpringBoots
#do
#    SpringBoot=$sb
#    break
#done

echo "$SpringBoot" 
 
if [ "$SpringBoot" = "" ];
then
    echo -e "\033[0;31m 未输入应用名 \033[0m"
    exit 1
fi
 
function start()
{
	count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
	if [ $count != 0 ];then
		echo "$SpringBoot is running..."
	else
		nohup java $JAVA_OPTS -jar $SpringBoot > /dev/null 2>&1 &
		echo "Start $SpringBoot success..."
	fi
}
 
function stop()
{
	echo "Stop $SpringBoot"
	boot_id=`ps -ef |grep java|grep $SpringBoot|grep -v grep|awk '{print $2}'`
	echo "boot_id=$boot_id"
	count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
        echo "count=$count"
	if [ $count != 0 ];then
	    kill $boot_id
    	count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
 
		boot_id=`ps -ef |grep java|grep $SpringBoot|grep -v grep|awk '{print $2}'`
		kill -9 $boot_id
	fi
}
 
function restart()
{
	stop
	sleep 2
	start
}
 
function status()
{
    count=`ps -ef |grep java|grep $SpringBoot|grep -v grep|wc -l`
    if [ $count != 0 ];then
        echo "$SpringBoot is running..."
    else
        echo "$SpringBoot is not running..."
    fi
}
 
case $1 in
	start)
	start;;
	stop)
	stop;;
	restart)
	restart;;
	status)
	status;;
	*)
 
	echo -e "\033[0;31m Usage: \033[0m  \033[0;34m sh  $0  {start|stop|restart|status}  {SpringBootJarName} \033[0m
\033[0;31m Example: \033[0m
	  \033[0;33m sh  $0  start esmart-test.jar \033[0m"
esac
