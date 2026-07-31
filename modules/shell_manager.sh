#!/usr/bin/env bash
# ==============================================================================
# Shell Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_shell_manager() {
    log_section "Shell Manager"

    log_info "Configuring default user shell..."
    local target_shell="${PREFIX:-/data/data/com.termux/files/usr}/bin/zsh"

    if [[ -x "${target_shell}" ]]; then
        if command -v chsh >/dev/null 2>&1; then
            log_info "Setting default shell to Zsh..."
            chsh -s zsh || true
        fi
    else
        log_info "Default shell remains Bash."
    fi

    # Create shell profiles if missing
    if [[ ! -f "$HOME/.zshrc" ]]; then
        cat <<'EOF' > "$HOME/.zshrc"
# Termux Bootstrap Zsh Configuration
export PATH="$PREFIX/bin:$HOME/.termux-bootstrap/bin:$PATH"
alias ll="ls -la"
alias doctor="bash $HOME/SETUP/TERMUX/termux-bootstrap-v4/doctor.sh"
EOF
    fi

    state_db_add_item "installed_modules" "shell_manager"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_shell_manager
fi
