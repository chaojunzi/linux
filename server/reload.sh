#!/bin/bash
root_path=$(cd "$(dirname "$0")";pwd)
cd $root_path
./admin.sh stop $1
sleep 1
./admin.sh start $1
