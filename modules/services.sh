#!/usr/bin/env bash
# ==============================================================================
# Termux Services & Termux:Boot Automation Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_services_manager() {
    log_section "Termux Services & Boot Manager"

    if [[ "${ENABLE_TERMUX_SERVICES:-1}" -ne 1 ]]; then
        log_info "ENABLE_TERMUX_SERVICES disabled in config.env. Skipping."
        return 0
    fi

    log_info "Evaluating background services & Termux:Boot setup..."

    # Configure Termux:Boot auto-startup script
    local boot_dir="$HOME/.termux/boot"
    mkdir -p "${boot_dir}"
    local boot_script="${boot_dir}/00-bootstrap-services"

    cat <<'EOF' > "${boot_script}"
#!/data/data/com.termux/files/usr/bin/sh
# Termux:Boot Service Auto-Launcher
if command -v termux-wake-lock >/dev/null 2>&1; then
    termux-wake-lock
fi

if [ -f /data/data/com.termux/files/usr/etc/profile.d/start-services.sh ]; then
    . /data/data/com.termux/files/usr/etc/profile.d/start-services.sh
fi

if command -v sv >/dev/null 2>&1; then
    sv up sshd 2>/dev/null || true
fi
EOF
    chmod 755 "${boot_script}"
    log_info "Termux:Boot startup script created at ${boot_script}"

    if command -v sv-enable >/dev/null 2>&1; then
        log_info "Enabling sshd service via sv-enable..."
        sv-enable sshd 2>/dev/null || true
        state_db_add_item "installed_modules" "services"
        log_success "Termux sshd service & Termux:Boot integration completed."
    else
        log_warn "termux-services package not initialized yet. Skipping runit setup."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_services_manager
fi
