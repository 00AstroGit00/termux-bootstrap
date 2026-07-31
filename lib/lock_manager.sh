#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Concurrency Lock Manager
# ==============================================================================
# Ensures single-instance execution via process lockfiles with secure permissions.
# ==============================================================================

set -euo pipefail

LOCK_DIR="${BOOTSTRAP_LOCK_DIR:-$HOME/.termux-bootstrap/locks}"
LOCK_FILE="${LOCK_DIR}/bootstrap.lock"

acquire_lock() {
    (umask 077 && mkdir -p "${LOCK_DIR}")

    exec 200>"${LOCK_FILE}"
    if command -v flock >/dev/null 2>&1; then
        if ! flock -n 200; then
            echo "[ERROR] Another instance of Termux Bootstrap is already running!" >&2
            exit 1
        fi
    else
        if [[ -f "${LOCK_FILE}.pid" ]]; then
            local pid
            pid=$(cat "${LOCK_FILE}.pid" 2>/dev/null || echo "")
            if [[ -n "${pid}" ]] && kill -0 "${pid}" 2>/dev/null; then
                echo "[ERROR] Another instance (PID ${pid}) is currently running!" >&2
                exit 1
            fi
        fi
        (umask 077 && echo "$$" > "${LOCK_FILE}.pid")
    fi
}

release_lock() {
    if command -v flock >/dev/null 2>&1; then
        flock -u 200 2>/dev/null || true
    fi
    rm -f "${LOCK_FILE}.pid" 2>/dev/null || true
}
