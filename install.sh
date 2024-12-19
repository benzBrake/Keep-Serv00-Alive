#!/bin/sh
# 允许执行程序
devil binexec on

# 存储用户名并转换为小写
USERNAME=${USER}
LC_USERNAME=$(echo ${USER} | tr '[:upper:]' '[:lower:]')

# 安装 PM2
if [ -z "$(command -v pm2)" ]; then
    mkdir -p /home/${USERNAME}/.npm-global
    npm config set prefix '/home/${USERNAME}/.npm-global'
    grep ".npm-global/bin" /home/${USERNAME}/.profile > /dev/null
    if [ $? -ne 0 ]; then
        echo 'export PATH=/home/${USERNAME}/.npm-global/bin:$PATH' >> /home/${USERNAME}/.profile
    . /home/${USERNAME}/.profile
    fi
    npm install -g pm2
fi
. /home/${USERNAME}/.profile

# 删除默认网站
devil www del ${LC_USERNAME}.serv00.net
rm -rf /home/${USERNAME}/domains/${LC_USERNAME}.serv00.net

# 创建网站
devil www add ${LC_USERNAME}.serv00.net nodejs $(command -v node22) production

# 安装网页
mv /home/${USERNAME}/domains/${LC_USERNAME}.serv00.net/public_nodejs/public /home/${USERNAME}/domains/${LC_USERNAME}.serv00.net/public_nodejs/static
curl -sL https://raw.githubusercontent.com/benzBrake/Keep-Serv00-Alive/master/app.js -o /home/${USERNAME}/domains/${LC_USERNAME}.serv00.net/public_nodejs/app.js
sed -i '' "s/USERNAME_TO_REPLACE/${USERNAME}/g" "/home/${USERNAME}/domains/${LC_USERNAME}.serv00.net/public_nodejs/app.js"
cd /home/${USERNAME}/domains/${LC_USERNAME}.serv00.net/public_nodejs
npm22 install express

# 访问网页
curl -sL https://${LC_USERNAME}.serv00.net

# 显示所有进程
ps aux