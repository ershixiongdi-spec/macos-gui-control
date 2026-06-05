# macOS GUI Control

控制 macOS 桌面 GUI 应用的工具包。无需外部 API，利用 macOS 原生能力 + cliclick 实现。

## 核心原理

```
┌─────────────────────────────────┐
│        macOS GUI Control        │
├─────────────────────────────────┤
│  Layer 1: AppleScript (精准控制) │
│  osascript → System Events      │
├─────────────────────────────────┤
│  Layer 2: cliclick (鼠标模拟)    │
│  cliclick → CGEvent             │
├─────────────────────────────────┤
│  Layer 3: screencapture (截图)   │
│  screencapture → PNG → vision   │
├─────────────────────────────────┤
│  Layer 4: hammerspoon (窗口布局) │
│  Lua config → 快捷键/布局       │
└─────────────────────────────────┘
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
├── SKILL.md
└── scripts/
    └── guicontrol.sh
```

## 测试环境

| 机器 | macOS | OpenClaw | cliclick | 状态 |
|------|-------|----------|----------|------|
| Mac Studio (本機) | 26.5 Sequoia | ✅ 2026.4.15 | ✅ | ✅ 全部正常 |
| Mac Pro (远程) | 13.7.8 Ventura | ✅ 2026.4.15 (Gateway) | ✅ | ✅ 全部正常 |

## 部署方式

1. GUI 控制能力通过 SSH 同步到远程 Mac Pro
2. 通过 VNC 查看远程桌面 (`vnc://10.0.7.172`)
3. SSH 执行 GUI 控制命令到远程 Mac Pro

## 许可证

MIT
