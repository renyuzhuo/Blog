#!/bin/bash
#定义函数

p() {
    echo "$1"
}

# 更行软件源
updateSS() {
    version=`python python/main.py`
    p "ubuntu version $version"
    sh ./shell/source.list.sh $version
}
