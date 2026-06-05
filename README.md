# macOS GUI Control

控制 macOS 桌面 GUI 应用的工具包。无需外部 API，利用 macOS 原生能力 + cliclick 实现。

## 核心原理

```
┌─────────────────────────────────────┐
│           macOS GUI Control          │
├─────────────────────────────────────┤
│  Layer 1: AppleScript (精准控制)      │
│  osascript → System Events → 应用   │
├─────────────────────────────────────┤
│  Layer 2: cliclick (鼠标模拟)        │
│  cliclick → CGEvent → 坐标点击      │
├─────────────────────────────────────┤
│  Layer 3: screencapture (截图)       │
│  screencapture → PNG → vision 分析  │
├─────────────────────────────────────┤
│  Layer 4: hammerspoon (窗口管理)     │
│  Lua config → 窗口布局/快捷键        │
└─────────────────────────────────────┘
```

## 快速开始

### 安装依赖

```bash
brew install cliclick
# hammerspoon (可选): brew install hammerspoon
```

### 权限配置

| 权限 | 路径 |
|------|------|
| 辅助功能 | 系统设置 → 隐私与安全性 → 辅助功能 |
| 屏幕录制 | 系统设置 → 隐私与安全性 → 屏幕录制 |

### 核心命令

```bash
# 获取前台应用
osascript -e 'tell application "System Events" to get name of first process whose frontmost is true'

# 激活应用
osascript -e 'tell application "Safari" to activate'

# 鼠标点击
cliclick c:100,200

# 截屏
screencapture -x /tmp/screen.png
```

## 文件结构

```
macos-gui-control/
├── README.md
├── SKILL.md          # OpenClaw skill 定义
└── scripts/
    └── guicontrol.sh # helper 脚本
```

## 远程 GUI 控制

通过 VNC 连接远程 macOS：

```bash
# 1. 开启远程桌面 (目标 Mac)
# 系统设置 → 通用 → 共享 → 远程管理

# 2. 连接
vnc://10.0.7.172

# 3. 远程执行命令 (SSH 到目标 Mac)
ssh user@10.0.7.172 'osascript -e "..."
```

## 测试环境

- macOS Sequoia 26.5
- cliclick 5.1
- Node.js 26

## 许可证

MIT
