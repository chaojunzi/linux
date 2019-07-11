#!/bin/bash
root_path=$(cd "$(dirname "$0")";pwd)
cd $root_path/../conf

AppName="`grep app.name application.properties | cut -d'=' -f2 | sed 's/\r//'`";

java_jps=`jps -v | egrep $AppName | awk -F' ' '{print $1,$2}' |  xargs echo`;
java_jps=($java_jps);

echo $java_jps

java_tomcat_num=${#java_jps[@]};
echo "java:num（$AppName->）：$[$java_tomcat_num/2]";
i=0;
while [ $i -lt ${#java_jps[@]} ]  
do
   t_pid=${java_jps[$i]};
    let i++;
   echo "server：${java_jps[$i]}"+"--->PID：${t_pid}";
   let i++;
    jstat -gcutil ${t_pid}
done
