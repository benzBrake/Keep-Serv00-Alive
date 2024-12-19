# Serv00服务器不优雅的保活方案

方案来自[[hkfires/Keep-Serv00-Alive](https://github.com/hkfires/Keep-Serv00-Alive)]，但是因为都是写死保活什么程序，用起来不方便，所以结合 AI 改成了保活 pm2 的版本，同时也弄了一键安装脚本。

## 使用注意

**会删除默认网站并切换为 node.js 模式，请注意备份数据**

## 使用方法

1. 登录 SSH，执行下下面的命令

   ```shell
   fetch -o - https://raw.githubusercontent.com/benzBrake/Keep-Serv00-Alive/master/install.sh?timestamp=$(date +%s) | sh
   ```

2. 因为安装了 pm2，可以使用 pm2 运行你的程序了。但这里不会说明 pm2 怎么用