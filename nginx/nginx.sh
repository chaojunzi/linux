#!/bin/bash
mkdir /usr/local/nginx
#依赖
yum -y install gcc-c++ 
yum -y install pcre pcre-devel 
yum -y install zlib zlib-devel
yum -y install openssl openssl-devel
#pcre 正则库
mkdir /usr/local/nginx/pcre
tar -zxvf /tmp/package/nginx/pcre-8.41.tar.gz -C /usr/local/nginx/pcre
cd /usr/local/nginx/pcre/pcre-8.41
./configure --enable-utf8
make && make install
#nginx
cd /tmp/package/nginx
nginxPath=/usr/local/nginx

tar -zxvf /tmp/package/nginx/nginx-1.12.2.tar.gz -C $nginxPath
tar -zxvf /tmp/package/nginx/ngx_cache_purge-2.3.tar.gz -C $nginxPath

cd $nginxPath
mkdir sys log 
mkdir -p temp/client
mkdir -p temp/proxy
mkdir -p temp/fastcgi
mkdir -p temp/uwsgi
mkdir -p temp/scgi
mkdir -p temp/resource/images_temp
mkdir -p temp/resource/images_cache

cd nginx-1.12.2
./configure  --prefix=/usr/local/nginx --with-pcre=../pcre/pcre-8.41 --with-pcre-jit --add-module=../ngx_cache_purge-2.3 --with-http_stub_status_module --with-http_ssl_module --pid-path=/usr/local/nginx/sys/nginx.pid  --lock-path=/usr/local/nginx/sys/nginx.lock --error-log-path=/usr/local/nginx/log/error.log --http-log-path=/usr/local/nginx/log/access.log --with-http_gzip_static_module  --http-client-body-temp-path=/usr/local/nginx/temp/client --http-proxy-temp-path=/usr/local/nginx/temp/proxy --http-fastcgi-temp-path=/usr/local/nginx/temp/fastcgi --http-uwsgi-temp-path=/usr/local/nginx/temp/uwsgi --http-scgi-temp-path=/usr/local/nginx/temp/scgi --with-stream --with-stream_ssl_module --with-http_stub_status_module
make && make install


nginxIp=`ifconfig | grep inet | head -n 1 | awk  -F' ' '{print $2}'`;
echo "ip:$nginxIp"
cp -f /tmp/package/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf
sed -i "s/domain/$nginxIp/g" /usr/local/nginx/conf/nginx.conf
mkdir -p /usr/local/nginx/conf/conf.d/tcp
mkdir  /usr/local/nginx/conf/conf.d/http
#start
/usr/local/nginx/sbin/nginx