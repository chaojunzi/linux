#!/bin/bash
trashdir=/tmp/trash
cd ${trashdir}
find ./ -mtime +3 -exec 'rm' -rf {} \;       #找到回收站中修改日期大于3天的文件，执行真正的删除
