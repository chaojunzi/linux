#ftp  https://www.cnblogs.com/ldl1137/p/7102694.html
yum -y install vsftpd
systemctl start vsftpd 

#限制匿名用户登录
vim /etc/vsftpd/vsftpd.conf

anonymous_enable=NO 
anon_upload_enable=YES
anon_mkdir_write_enable=YES

systemctl restart  vsftpd

#建立ftp虚拟宿主帐户
useradd lefu -d /data/lefu  -s /sbin/nologin
passwd lefu   -> lefu

getsebool -a | grep ftp

setsebool -P allow_ftpd_full_access on 
setsebool -P tftp_home_dir on

#限制系统用户锁定在/data/lefu目录
vim /etc/vsftpd/vsftpd.conf

chroot_local_user=NO
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list

vim /etc/vsftpd/vsuser
lefuadmin
Lefu?123#456
db_load -T -t hash -f /etc/vsftpd/vsuser /etc/vsftpd/vsuser.db


systemctl  stop vsftpd.service
systemctl  start vsftpd.service
systemctl  restart vsftpd.service

