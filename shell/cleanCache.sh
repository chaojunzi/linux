#!/bin/bash
#每两小时清除一次缓存
echo "开始清除缓存"
sync;sync;sync
sleep 10
echo 1 > /proc/sys/vm/drop_caches

#仅清除页面缓存（PageCache）
# sync; echo 1 > /proc/sys/vm/drop_caches

#清除目录项和inode
# sync; echo 2 > /proc/sys/vm/drop_caches

#清除页面缓存，目录项和inode
# sync; echo 3 > /proc/sys/vm/drop_caches
