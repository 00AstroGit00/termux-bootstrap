#!/usr/bin/env bash
# ==============================================================================
# Custom Installer Adapter: Termux Build-Essential Toolchain
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_installer_build_essential() {
    log_section "Custom Installer: Termux Build Essential"

    if state_db_has_item "installed_installers" "termux-build-essential"; then
        log_info "Build Essential toolchain already installed."
        return 0
    fi

    log_info "Installing clang, make, pkg-config, build-essential..."
    if command -v pkg >/dev/null 2>&1; then
        pkg install -y build-essential clang make || true
    fi

    state_db_add_item "installed_installers" "termux-build-essential"
    log_success "Build Essential installer completed."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_installer_build_essential
fi
