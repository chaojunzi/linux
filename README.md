## linux  docker   shell脚本  nginx 依赖模块  权限管理    
#### 服务文件夹目录
##### /bin  启动脚本  
##### /conf  配置文件  
##### /resource 资源文件如 html/css/js 等  
##### /server  运行的jar包  
##### /logs 日志  

#### 查看进程异常退出
##### dmesg -T | grep "(java)"

#### mysql
##### Host '124.202.183.18' is blocked because of many connection errors; unblock with 'mysqladmin flush-hosts
flush hosts;
