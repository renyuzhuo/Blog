#!/bin/bash
. ./shell/function.sh

sudo cp /etc/apt/sources.list /etc/apt/sources.list-backup

if [ $1 -eq 16 ]; then
    sudo chmod 777 /etc/apt/sources.list
    sudo cat ./shell/source.list.d/source.list-16.04 >> /etc/apt/sources.list
    sudo chmod 644 /etc/apt/sources.list
elif [ $1 -eq 14 ]; then
    sudo chmod 777 /etc/apt/sources.list
    sudo cat ./shell/source.list.d/source.list-14.04 >> /etc/apt/sources.list
    sudo chmod 644 /etc/apt/sources.list
    
    sudo add-apt-repository ppa:openjdk-r/ppa
fi

# p "wget google key"
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
