#配置环境变量
vim /etc/profile
source /etc/profile


export JAVA_HOME=/usr/local/java/jdk1.8.0_181
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin

#启动防火墙
systemctl start  firewalld

#linux   doc文件转unix文件
yum install dos2unix
:set ff=unix


#配置别名快捷键
vim /etc/bashrc
alias rm="/usr/local/sbin/remove.sh"
source /etc/bashrc

vim ~/.bashrc
alias gonginx='cd /usr/local/nginx/conf/conf.d'
alias golefu='cd /softrun/tech/lefu'
alias mem_fcwl='/softrun/tech/fcwl/bin/mem-java.sh'
alias golog_fcwl='xc_gologfcwl(){ cd /logs/fcwl_cloud/fcwl-$1/info;};xc_gologfcwl'
alias fcwl_tail_log='xc_fcwltaillog(){ tail -f /logs/fcwl_cloud/fcwl-$1/info/info-$(date +%Y-%m-%d).log;};xc_fcwltaillog'
source ~/.bashrc

#定时器
12 10 * * *  /usr/local/sbin/cleartrash.sh
12 0  * * *  /usr/local/sbin/cleanCache.sh
1 0  * * *  /usr/local/sbin/deleteLogs.sh
#配置结束