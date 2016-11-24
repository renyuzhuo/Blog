# ubuntu-config

Ubuntu一建配置

### How To Use

```shell
wget https://github.com/RWebRTC/ubuntu-config/archive/master.zip
unzip master.zip
mv ubuntu-config-master ubuntu-config # 这一步必不可少
sh ubuntu-config/main.sh -d
```

```shell
git clone git@github.com:RWebRTC/ubuntu-config.git
sh ubuntu-config/main.sh -d
```

### Help

```
$sh main.sh -h
[-g] [-a] [-j] [-6] [-7] [-8] [-i] [-k] [-h] [-u] [-d]

建议新装系统执行：
  ./main.sh -g -u -i -j8 -k
或：
  ./main.sh -d

参数：
    -h 帮助
    -u apt-get update
    -j 配置默认java
    -6 安装openJDK-6
    -7 安装openJDK-7
    -8 安装openJDK-8
    -k ssh-key -> ~/.ssh/github-rsa
    -i 安装常用软件
    -a 安装所有软件
    -g warn：更新hosts
    -d 默认配置

```

### Reference

[system-config](https://github.com/baohaojun/system-config)

