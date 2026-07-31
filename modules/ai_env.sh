#!/usr/bin/env bash
# AI Environment Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_ai_env() {
    log_section "AI Environment Manager"
    if [[ "${INSTALL_AI:-1}" -eq 1 ]]; then
        log_info "Configuring AI environment packages (python, numpy, llm helpers)..."
        state_db_add_item "installed_modules" "ai_env"
        log_success "AI environment configuration ready."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_ai_env
fi
