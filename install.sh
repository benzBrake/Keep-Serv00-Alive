#!/bin/sh
# 允许执行程序
devil binexec on
# 安装 PM2
if [ -z "$(command -v pm2)" ]; then
    mkdir -p /home/${USER}/.npm-global
    npm config set prefix '/home/${USER}/.npm-global'
    grep ".npm-global/bin" /home/${USER}/.profile > /dev/null
    if [ $? -ne 0 ]; then
        echo 'export PATH=/home/${USER}/.npm-global/bin:$PATH' >> /home/${USER}/.profile
    . /home/${USER}/.profile
    fi
    npm install -g pm2
fi
. /home/${USER}/.profile
# 删除默认网站
devil www del ${USER}.serv00.net
rm -rf /home/${USER}/domains/${USER}.serv00.net
# 创建网站
devil www add ${USER}.serv00.net nodejs $(command -v node22) production
# 安装网页
mv /home/${USER}/domains/${USER}.serv00.net/public_nodejs/public /home/${USER}/domains/${USER}.serv00.net/public_nodejs/static
curl -sL https://raw.githubusercontent.com/benzBrake/Keep-Serv00-Alive/master/app.js -o /home/${USER}/domains/${USER}.serv00.net/public_nodejs/app.js
sed "s/USERNAME_TO_REPLACE/${USER}/g" /home/${USER}/domains/${USER}.serv00.net/public_nodejs/app.js
cd /home/${USER}/domains/${USER}.serv00.net/public_nodejs
npm22 install express

# 访问网页
curl -sL https://${USER}.serv00.net

# 显示所有进程
ps aux