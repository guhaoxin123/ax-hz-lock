# 屏幕刷新率锁定

<img src="banner.jpg" width="100%">

读取屏幕支持的最高刷新率并锁定，锁屏、省电、部分应用下也保持高刷；操作按钮可查看当前帧率与设备信息。

## 功能
- 从 `dumpsys display` / `dumpsys SurfaceFlinger` 解析屏幕最高刷新率
- 写入 `peak_refresh_rate`、`min_refresh_rate`、`user_refresh_rate`（system 与 secure 双份）
- 切 `refresh_rate_mode=2`，兼容 vivo 的 `vivo_screen_refresh_rate_mode`
- 操作按钮：显示当前帧率、Android 版本、内核、处理器信息

## 安装
1. 到 [Releases](../../releases) 下载 `ax-hz-lock-v3.1.zip`
2. AxManager / 模块管理器从本地导入
3. 重启生效，或点操作按钮立刻锁一次

## 文件
| 文件 | 说明 |
|---|---|
| `module.prop` | 模块信息 |
| `service.sh` | 锁最高刷新率 + 读取当前帧率 |
| `action.sh` | 操作按钮：设备信息面板 |
| `customize.sh` / `post-fs-data.sh` | 安装期与开机逻辑 |
| `banner.jpg` | 模块头图 |

## 说明
作者 ghx；本仓库由 DSH 整理、重命名并统一打包。
