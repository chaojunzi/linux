#!/bin/bash
user_name="`echo $USER`"
prefix=""
if [ ! $user_name = "root" ];then
 prefix="sudo "
fi
$prefix /usr/local/nginx/sbin/nginx -s reload
