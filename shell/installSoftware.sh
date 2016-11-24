#!/bin/bash
# install software

. ./shell/function.sh

p "install git"
sudo apt-get install git
p "install vim"
sudo apt-get install vim
p "install tree"
sudo apt-get install tree
p "install python3"
sudo apt-get install python3

# read -r -p "install Chrome [y/N]:" ic
# case $gitConfig ic
#     [yY][eE][sS]|[yY]) 
#         p "install Chrome"
#         sudo apt-get install google-chrome-stable
#     *)
#         ;;
# esac

