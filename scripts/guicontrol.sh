#!/bin/bash
# macOS GUI Control Helper Scripts
set -euo pipefail

# ========== 通用 ======

# 检查 Accessibility 权限
check_accessibility() {
    if osascript -e 'tell application "System Events" to get name of every process' 2>/dev/null | grep -qi "error"; then
        echo "⚠️ 缺少 Accessibility 权限"
        echo "请在 系统设置 → 隐私与安全性 → 辅助功能 中授权"
        return 1
    else
        echo "✅ Accessibility 权限正常"
        return 0
    fi
}

# 检查屏幕录制权限
check_screen_capture() {
    if screencapture /tmp/.gui_test_capture.png 2>/dev/null; then
        rm -f /tmp/.gui_test_capture.png
        echo "✅ 屏幕录制权限正常"
        return 0
    else
        echo "⚠️ 缺少屏幕录制权限"
        echo "请在 系统设置 → 隐私与安全性 → 屏幕录制 中授权"
        return 1
    fi
}

# 获取所有运行中的应用
get_running_apps() {
    osascript -e 'tell application "System Events" to get name of every process' 2>/dev/null | tr ',' '\n' | sed 's/^ *//;s/ *$//' | grep -v '^$' | sort
}

# 获取当前前台应用
get_active_app() {
    osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null
}

# 激活某个应用
activate_app() {
    local app="$1"
    osascript -e "tell application \"$app\" to activate" 2>/dev/null
}

# 关闭某个应用
close_app() {
    local app="$1"
    osascript -e "tell application \"$app\" to quit" 2>/dev/null
}

# 检查应用是否运行
is_app_running() {
    local app="$1"
    osascript -e "tell application \"System Events\" to (exists (processes whose name is \"$app\"))" 2>/dev/null | grep -q "true"
}

# 获取屏幕分辨率
get_screen_size() {
    system_profiler SPDisplaysDataType 2>/dev/null | grep Resolution
}

# 截屏
take_screenshot() {
    local output="${1:-/tmp/screenshot_$(date +%s).png}"
    screencapture -x "$output" 2>/dev/null && echo "✅ 截图完成: $output" || echo "❌ 截图失败"
}

# ========== 安装检查 ====

check_dependencies() {
    echo "== macOS GUI Control 依赖检查 =="
    echo ""
    
    # osascript
    if command -v osascript >/dev/null 2>&1; then
        echo "✅ osascript (macOS 自带)"
    else
        echo "❌ osascript (系统自带)"
    fi
    
    # screencapture
    if command -v screencapture >/dev/null 2>&1; then
        echo "✅ screencapture (系统自带)"
    else
        echo "❌ screencapture (系统自带)"
    fi
    
    # cliclick
    if command -v cliclick >/dev/null 2>&1; then
        cliclick p >/dev/null 2>&1 && cliclick_ver="✅ cliclick 正常" || cliclick_ver="⚠️ cliclick 需辅助功能权限"
        echo "$cliclick_ver"
    else
        echo "❌ cliclick 未安装: brew install cliclick"
    fi
    
    # hammerspoon
    if command -v hammerspoon >/dev/null 2>&1; then
        echo "✅ hammerspoon installed"
    else
        echo "ℹ️ hammerspoon 未安装 (可选): brew install hammerspoon"
    fi
    
    echo ""
    echo "== 权限检查 =="
    check_accessibility
    check_screen_capture
    
    echo ""
    echo "== 当前状态 =="
    echo "前台应用: $(get_active_app)"
    local count
    count=$(get_running_apps | wc -l | tr -d ' ')
    echo "运行中应用: $count 个"
}

# 如果直接执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    case "${1:-help}" in
        check-perm) check_accessibility ;;
        check-screencapture) check_screen_capture ;;
        apps) get_running_apps ;;
        active) get_active_app ;;
        screen) get_screen_size ;;
        screenshot) take_screenshot "${2:-/tmp/screenshot.png}" ;;
        deps) check_dependencies ;;
        help|*)
            echo "macOS GUI Control Helper Scripts"
            echo ""
            echo "用法:"
            echo "  $0 check-perm     检查辅助功能权限"
            echo "  $0 check-screen  检查屏幕录制权限"
            echo "  $0 apps          列出运行中的应用"
            echo "  $0 active        当前激活的应用"
            echo "  $0 screen        屏幕分辨率"
            echo "  $0 screenshot    截屏"
            echo "  $0 deps          检查依赖和权限"
            ;;
    esac
fi
