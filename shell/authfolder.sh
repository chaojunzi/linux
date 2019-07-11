#!/bin/bash
file_name=$1

#授权
chmod g+w $file_name
chmod g+s $file_name
chmod o+t $file_name
chown :tech $file_name
