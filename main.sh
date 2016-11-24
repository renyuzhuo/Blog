#!/bin/bash

cd ~/ubuntu-config
. ./shell/function.sh

while getopts 'hgj678kiaud' OPT; do
    case $OPT in
        h)
            p "[-g] [-a] [-j] [-6] [-7] [-8] [-i] [-k] [-h] [-u] [-d]"
            p ""
            p "建议新装系统执行："
            p "  ./main.sh -g -u -i -j8 -k"
            p "或："
            p "  ./main.sh -d"
            p ""
            p "参数："
            p "    -h 帮助"
            p "    -u apt-get update"
            p "    -j 配置默认java"
            p "    -6 安装openJDK-6"
            p "    -7 安装openJDK-7"
            p "    -8 安装openJDK-8"
            p "    -k ssh-key -> ~/.ssh/github-rsa"
            p "    -i 安装常用软件"
            p "    -a 安装所有软件"
            p "    -g warn：更新hosts"
            p "    -d 默认配置"
            exit 0
            ;;
        g)
            configHost="true" ;;
        j)
            configJava="true" ;;
        6)
            configJava6="true" ;;
        7)
            configJava7="true" ;;
        8)
            configJava8="true" ;;
        k)
            configGitHub="true" ;;
        i)
            configSoftware="true" ;;
        a)
            configAll="true" ;;
        u)
            configUpdate="true" ;;
        d)
            configHost="true"
            configUpdate="true"
            configSoftware="true"
            configJava="true"
            configJava8="true"
            configGitHub="true"
            ;;
    esac
done

configFile="./shell/configFile"
if [ ! -f "$configFile" ]
then 
    touch "$configFile"
    new="y"
    p "the first install"
else 
    read -r -p "not first install, cover [y/N]:" new
fi 

case $new in
    [yY][eE][sS]|[yY]) 
        read -r -p "update software source [y/N]:" updateSoftwareSource
        case $updateSoftwareSource in
            [yY][eE][sS]|[yY])
                updateSS ;;
            *)
                ;;
        esac
        ;;
    *)
        ;;
esac

if [ -n "$configHost" ]
then
    p "update hosts"
    sudo cp /etc/hosts /etc/host-backup
    sudo cat ./shell/hosts >> /etc/hosts
fi

if [ -n "$configUpdate" ]
then
    p "sudo apt-get update"
    sudo apt-get update
fi

if [ -n "$configSoftware" ]
then
    p 'install software'
    sh ./shell/installSoftware.sh
fi

if [ -n "$configJava6" ]
then
    p "install openjdk-6"
    sudo apt-get install openjdk-6-jdk
fi

if [ -n "$configJava7" ]
then
    p "install openjdk-7"
    sudo apt-get install openjdk-7-jdk
fi

if [ -n "$configJava8" ]
then
    p "install openjdk-8"
    sudo apt-get install openjdk-8-jdk
fi


if [ -n "$configAll" ]
then
    p 'all install'
    sh ./shell/installSoftware.sh
    p "install openjdk-6"
    sudo apt-get install openjdk-6-jdk
    p "install openjdk-7" 
    sudo apt-get install openjdk-7-jdk
    p "install openjdk-8" 
    sudo apt-get install openjdk-8-jdk
    configJava="true"
fi

if [ -n "$configJava" ]
then
    p "config JDK"
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
else
    p "not config Java"
fi

if [ -n "$configGitHub" ]
then
    p "config github-rsa"
    read -r -p "Email:" email
    ssh-keygen -t rsa -C "$email" -f ~/.ssh/github-rsa
else
    p "not config github-rsa"
fi

read -r -p "config git [y/N]:" gitConfig

case $gitConfig in
    [yY][eE][sS]|[yY]) 
        read -r -p "git config user.name:" uname
        git config --global user.name "$uname"
        read -r -p "git config user.email:" uemail
        git config --global user.email "$uemail"
        ;;
    *)
        ;;
esac

p ""
cd ~
configFile="./work"
if [ ! -d "$configFile" ]; then
    p "create work dir: ~/work" 
    mkdir -p "$configFile"
fi 
configFile="./src"
if [ ! -d "$configFile" ]; then
    p "create work dir: ~/src" 
    mkdir -p "$configFile"
fi

p "set path"
echo 'export PATH=~/ubuntu-config:~/ubuntu-config/shell:"$PATH"' >> ~/.bashrc

p ""
p "VSCode URL"
p "https://code.visualstudio.com/download"
p "sogou pinyin URL"
p "http://pinyin.sogou.com/linux/"
# p "Chrome URL"
# p "https://www.google.com/chrome/browser/desktop/index.html"
p ""
p "Project Index"
p "http://config.renyuzhuo.cn/"
p "Project Code"
p "https://github.com/RWebRTC/ubuntu-config"
p "Have Fun!"
exit 0
