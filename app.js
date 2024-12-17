const express = require('express');
const { exec } = require('child_process');
const path = require('path'); // Import the path module

const app = express();
const PORT = 3000;

app.use(express.static(path.join(__dirname, 'static')));

// 定义 pm2 的路径
const PM2_PATH = '/home/USERNAME_TO_REPLACE/.npm-global/bin/pm2';

// 检查是否有任何 pm2 进程处于 online 状态
function checkAndResurrectPM2() {
    exec(`${PM2_PATH} list`, (error, stdout, stderr) => {
        if (error) {
            console.error(`执行命令时出错: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`错误输出: ${stderr}`);
            return;
        }

        // 检查是否有 online 状态的进程
        if (!stdout.includes('online')) {
            // 如果没有找到 online 状态的进程，则执行 pm2 resurrect
            exec(`${PM2_PATH} resurrect`, (resurrectError, resurrectStdout, resurrectStderr) => {
                if (resurrectError) {
                    console.error(`执行 resurrect 时出错: ${resurrectError.message}`);
                    return;
                }
                if (resurrectStderr) {
                    console.error(`resurrect 错误输出: ${resurrectStderr}`);
                    return;
                }
                console.log(`resurrect 成功: ${resurrectStdout}`);
            });
        } else {
            console.log('已有 online 状态的进程，无需执行 resurrect');
        }
    });
}

setInterval(checkAndResurrectPM2, 10 * 1000);

// 启动服务器
app.listen(PORT, () => {
    console.log(`服务器正在运行在 http://localhost:${PORT}`);
});