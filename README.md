<div align="center">

# M9Auto

✨ 全自动 **1999** の 最后一公里 ✨

</div>

<div align="center">

  <a href="./README_EN.md"><img src="https://img.shields.io/badge/English-d9d9d9"></a>
  <a href="./README.md"><img src="https://img.shields.io/badge/简体中文-d9d9d9"></a>

</div>

M9Auto 是一个基于 [Waydroid](https://github.com/waydroid/waydroid) 和 [M9A](https://github.com/MaaXYZ/M9A) 的 重返未来：1999 自动化脚本，实现了在 Linux 环境下 Reverse：1999 的自动日常。

## 使用说明

### 环境配置

1. 前置条件：
- 配置 [Waydroid](https://github.com/waydroid/waydroid) 
- 在 Waydroid 中安装 重返未来：1999
- 安装 [M9A](https://github.com/MaaXYZ/M9A) 
- 在 M9A 中配置日常任务

2. 复制 `.env.example` 并重命名为 `.env`：
    ```sh
    cp .env.example .env
    ```

3. 编辑 `.env`，根据 `M9A` 路径配置 `M9A_CLI` 变量：
    ```env
    M9A_CLI=<M9A_PATH>/install/MaaPiCli
    ```

### 运行脚本

1. 确保 `auto_start.sh` 和 `run.sh` 具有可执行权限：
    ```sh
    chmod +x auto_start.sh run.sh
    ```

2. 将以下运行 `auto_start.sh` 的命令设置为开机自动执行：
    ```sh
    <BASH_PATH> <M9AUTO_PATH>/auto_start.sh
    ```

## 许可证

此项目采用 [MIT 许可证](./LICENSE)。