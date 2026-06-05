# macOS GUI Control Skill

控制 macOS 桌面 GUI 应用，无需外部 API。

## 测试状态（macOS Sequoia / Ventura）

| 功能 | 状态 | 说明 |
|------|------|------|
| osascript 应用控制 | ✅ | macOS 自带 |
| screencapture 截图 | ✅ | 需屏幕录制权限 |
| cliclick 鼠标模拟 | ✅ | 需辅助功能权限 |
| System Events 键盘模拟 | ✅ | 需辅助功能权限 |
| 窗口管理 | ✅ | osascript 控制 |
| hammerspoon 窗口布局 | ⚠️ | 可选安装 |

## 核心能力

### 1. AppleScript/osascript 应用控制

```bash
# 获取前台应用
osascript -e 'tell application "System Events" to get name of first process whose frontmost is true'

# 激活应用
osascript -e 'tell application "Safari" to activate'

# Safari 打开网页
osascript -e 'tell application "Safari" to make new tab at end of tabs of window 1 with properties {URL:"https://example.com"}'

# 系统通知
osascript -e 'display notification "任务完成" with title "二师兄"'

# 模拟按键
osascript -e 'tell application "System Events" to keystroke "c" using command down'

# 音量控制
osascript -e 'set volume output volume 50'

# 窗口管理
osascript -e 'tell application "System Events" to set bounds of window 1 of process "Safari" to {100, 100, 1400, 900}'
```

### 2. cliclick 鼠标键盘模拟

```bash
cliclick c:100,200     # 点击
cliclick m:100,200     # 移动
cliclick dr:100,200,300,400  # 拖拽
cliclick dc:100,200    # 双击
cliclick rc:100,200    # 右键
cliclick wd:100,200:10 # 滚动
cliclick p             # 获取鼠标位置
```

### 3. 截图

```bash
screencapture /tmp/screenshot.png
screencapture -x /tmp/screenshot.png    # 静默截图
screencapture -T 3 /tmp/screenshot.png  # 延迟 3 秒
```

## 依赖

| 依赖 | 安装 | 状态 |
|------|------|------|
| osascript | macOS 自带 | ✅ |
| screencapture | macOS 自带 | ✅ |
| cliclick | brew install | ⚠️ 需安装 |
| hammerspoon | brew install | 可选 |

## 权限

| 权限 | 路径 |
|------|------|
| 辅助功能 | 系统设置 → 隐私与安全性 → 辅助功能 |
| 屏幕录制 | 系统设置 → 隐私与安全性 → 屏幕录制 |
