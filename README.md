## linux  docker   shell脚本  nginx 依赖模块  权限管理    
#### 服务文件夹目录
##### /bin  启动脚本  
##### /conf  配置文件  
##### /resource 资源文件如 html/css/js 等  
##### /server  运行的jar包  
##### /logs 日志  

## 查看进程异常退出
##### dmesg -T | grep "(java)"

## mysql
-   安装地址 [mysql-5.7-centos7](https://www.linuxidc.com/Linux/2016-06/132676.htm)  
-   【异常】Host '124.202.183.18' is blocked because of many connection errors; unblock with 'mysqladmin flush-hosts  

```
flush hosts;
```

-  密码强度设置  

```
set global validate_password_policy=LOW;  
set global validate_password_length=6;   
set password = password('123456');  
grant all privileges on *.* to root@"%" identified by "123456";  
grant all privileges on *.* to root@"localhost" identified by "123456";  
flush privileges;  
```
- vim /etc/my.cnf

```
[client]
default-character-set = utf8mb4
[mysql]
default-character-set = utf8mb4
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
```