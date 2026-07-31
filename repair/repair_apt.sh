#!/usr/bin/env bash
# Repair Handler: APT Fix & Package Database Heal
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

heal_apt() {
    log_info "[Repair] Healing APT package database & lock files..."
    rm -f "${PREFIX:-/data/data/com.termux/files/usr}/var/lib/dpkg/lock"* 2>/dev/null || true
    if command -v dpkg >/dev/null 2>&1; then
        dpkg --configure -a 2>/dev/null || true
    fi
    if command -v pkg >/dev/null 2>&1; then
        pkg update -y 2>/dev/null || true
    fi
    log_success "[Repair] APT database heal completed."
}
heal_apt
