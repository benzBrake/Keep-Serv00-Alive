#!/bin/sh
# 允许执行程序
devil binexec on
# 安装 PM2
mkdir -p ~/.npm-global && npm config set prefix '~/.npm-global' && echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile && source ~/.profile && npm install -g pm2 && source ~/.profile
# 删除默认网站
devil www del ${USER}.serv00.net
# 创建网站
devil www add ${USER}.serv00.net nodejs $(command -v node22) production
# 安装网页
mv cd /home/${USER}/domains/${USER}.serv00.net/public_nodejs/public /home/${USER}/domains/${USER}.serv00.net/public_nodejs/static
curl -sL https://raw.githubusercontent.com/benzBrake/Keep-Serv00-Alive/master/index.js -o /home/${USER}/domains/${USER}.serv00.net/public_nodejs/index.js
sed "s/USERNAME_TO_REPLACE/${USER}/g" /home/${USER}/domains/${USER}.serv00.net/public_nodejs/index.js

curl -sL https://${USER}.serv00.net

ps aux