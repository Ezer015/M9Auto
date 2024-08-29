<div align="center">

# M9Auto

✨ Fully Automated **1999** の Last Mile ✨

</div>

<div align="center">

  <a href="./README.md"><img src="https://img.shields.io/badge/简体中文-d9d9d9"></a>
  <a href="./README_EN.md"><img src="https://img.shields.io/badge/English-d9d9d9"></a>

</div>

M9Auto is a script for automating daily tasks in the Reverse:1999 environment, based on [Waydroid](https://github.com/waydroid/waydroid) and [M9A](https://github.com/MaaXYZ/M9A) projects.

## Usage Instruction

### Environment Setup

1. Prerequisites:
    - Configure [Waydroid](https://github.com/waydroid/waydroid)
    - Install Reverse:1999 in Waydroid
    - Install [M9A](https://github.com/MaaXYZ/M9A)
    - Configure daily tasks in M9A

2. Clone the project locally
    ```sh
    git clone https://github.com/Ezer015/M9Auto
    ```

3. Copy `.env.sample` and rename it to `.env`:
    ```sh
    cp .env.sample .env
    ```

4. Edit `.env` and configure the `M9A_CLI` variable based on the `M9A` path:
    ```env
    M9A_CLI=<M9A_PATH>/install/MaaPiCli
    ```

### Running the Script

1. Ensure that `auto_start.sh` and `run.sh` have executable permissions:
    ```sh
    chmod +x auto_start.sh run.sh
    ```

2. Set the following command to run `auto_start.sh` on startup:
    ```sh
    <BASH_PATH> <M9AUTO_PATH>/auto_start.sh
    ```

## License

M9Auto is licensed under the [MIT License](./LICENSE).