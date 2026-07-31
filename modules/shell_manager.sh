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

    log_info "Configuring default user shell & modern CLI aliases..."
    local target_shell="${PREFIX:-/data/data/com.termux/files/usr}/bin/zsh"

    if [[ -x "${target_shell}" ]]; then
        if command -v chsh >/dev/null 2>&1; then
            log_info "Setting default shell to Zsh..."
            chsh -s zsh || true
        fi
    else
        log_info "Default shell remains Bash."
    fi

    # Create / update Zsh profile with modern aliases
    if [[ ! -f "$HOME/.zshrc" ]]; then
        cat <<'EOF' > "$HOME/.zshrc"
# Termux Bootstrap Zsh Configuration & Modern 2026 CLI Integrations
export PATH="$PREFIX/bin:$HOME/.termux-bootstrap/bin:$PATH"

# Modern CLI Tool Aliases
alias ll="ls -la"
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
fi

if command -v bat >/dev/null 2>&1; then
    alias cat="bat --paging=never"
fi

if command -v ripgrep >/dev/null 2>&1 || command -v rg >/dev/null 2>&1; then
    alias grep="rg"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

alias doctor="bash $HOME/.termux-bootstrap-framework/doctor.sh"
alias repair="bash $HOME/.termux-bootstrap-framework/repair.sh"
alias rollback="bash $HOME/.termux-bootstrap-framework/rollback.sh"
EOF
    fi

    state_db_add_item "installed_modules" "shell_manager"
    log_success "Shell Manager configuration completed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_shell_manager
fi
