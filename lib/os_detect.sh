#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - OS & Hardware Detection Engine
# ==============================================================================

set -euo pipefail

# Exported Global OS Environment Variables
export SYS_IS_TERMUX=0
export SYS_IS_ANDROID=0
export SYS_ARCH=""
export SYS_ANDROID_API=0
export SYS_TERMUX_PREFIX=""
export SYS_TERMUX_HOME=""
export SYS_TERMUX_APP_VERSION=""
export SYS_CPU_CORES=1
export SYS_TOTAL_RAM_MB=0
export SYS_AVAILABLE_DISK_MB=0

detect_system() {
    # Detect CPU Architecture
    local raw_arch
    raw_arch=$(uname -m 2>/dev/null || echo "unknown")
    case "${raw_arch}" in
        aarch64|arm64)
            SYS_ARCH="aarch64"
            ;;
        armv7l|armv8l|arm)
            SYS_ARCH="arm"
            ;;
        x86_64|amd64)
            SYS_ARCH="x86_64"
            ;;
        i686|x86)
            SYS_ARCH="i686"
            ;;
        *)
            SYS_ARCH="${raw_arch}"
            ;;
    esac

    # Detect Android / Termux Prefix
    if [[ -d "/data/data/com.termux/files/usr" || -n "${TERMUX_VERSION:-}" ]]; then
        SYS_IS_TERMUX=1
        SYS_IS_ANDROID=1
        SYS_TERMUX_PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
        SYS_TERMUX_HOME="${HOME:-/data/data/com.termux/files/home}"
        SYS_TERMUX_APP_VERSION="${TERMUX_VERSION:-unknown}"
    elif [[ -f "/system/bin/getprop" ]]; then
        SYS_IS_ANDROID=1
    fi

    # Detect Android SDK / API Level
    if command -v getprop >/dev/null 2>&1; then
        SYS_ANDROID_API=$(getprop ro.build.version.sdk 2>/dev/null || echo 0)
    elif [[ -f "/system/build.prop" ]]; then
        SYS_ANDROID_API=$(grep -E "^ro.build.version.sdk=" /system/build.prop 2>/dev/null | cut -d'=' -f2 || echo 0)
    fi

    # Detect Hardware Specs
    if command -v nproc >/dev/null 2>&1; then
        SYS_CPU_CORES=$(nproc 2>/dev/null || echo 1)
    elif [[ -r "/proc/cpuinfo" ]]; then
        SYS_CPU_CORES=$(grep -c "^processor" /proc/cpuinfo 2>/dev/null || echo 1)
    fi

    # Available Memory (MB)
    if [[ -r "/proc/meminfo" ]]; then
        local mem_kb
        mem_kb=$(grep -i "MemTotal" /proc/meminfo 2>/dev/null | awk '{print $2}' || echo 0)
        SYS_TOTAL_RAM_MB=$(( mem_kb / 1024 ))
    fi

    # Available Disk (MB) in HOME
    local df_out
    df_out=$(df -m "${HOME:-/}" 2>/dev/null | tail -n 1 | awk '{print $4}' || echo 0)
    SYS_AVAILABLE_DISK_MB="${df_out:-0}"
}

print_system_info() {
    detect_system
    echo "OS Architecture:       ${SYS_ARCH}"
    echo "Is Termux:             ${SYS_IS_TERMUX}"
    echo "Is Android:            ${SYS_IS_ANDROID}"
    echo "Android API Level:     ${SYS_ANDROID_API}"
    echo "Termux Prefix:         ${SYS_TERMUX_PREFIX}"
    echo "CPU Cores:             ${SYS_CPU_CORES}"
    echo "Total Memory (MB):     ${SYS_TOTAL_RAM_MB}"
    echo "Free Disk Space (MB):  ${SYS_AVAILABLE_DISK_MB}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    print_system_info
fi
