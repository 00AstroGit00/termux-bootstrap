#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Remote Web Installer Launcher
# ==============================================================================
# One-liner execution wrapper for fresh Termux Android installations.
# ==============================================================================

set -euo pipefail

TARGET_DIR="${HOME}/.termux-bootstrap-framework"
REPO_URL="https://github.com/00AstroGit00/termux-bootstrap.git"

echo "[INFO] Termux Bootstrap Framework Remote Bootstrapper"

# 1. Install missing dependencies (git, curl)
if ! command -v git >/dev/null 2>&1 || ! command -v curl >/dev/null 2>&1; then
    echo "[INFO] Installing required dependencies (git, curl)..."
    if command -v pkg >/dev/null 2>&1; then
        pkg update -y || true
        pkg install -y git curl
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get update -y || true
        apt-get install -y git curl
    fi
fi

# 2. Clone or update framework repository
if [[ -d "${TARGET_DIR}/.git" ]]; then
    echo "[INFO] Updating existing framework installation in ${TARGET_DIR}..."
    git -C "${TARGET_DIR}" pull --rebase || true
else
    echo "[INFO] Cloning framework repository to ${TARGET_DIR}..."
    rm -rf "${TARGET_DIR}"
    git clone "${REPO_URL}" "${TARGET_DIR}"
fi

# 3. Transfer execution to bootstrap orchestrator
cd "${TARGET_DIR}"
exec bash "${TARGET_DIR}/bootstrap.sh" "$@"
