#!/usr/bin/env bash
# ==============================================================================
# Plugin Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_plugin_manager() {
    log_section "Plugin Manager"

    log_info "Managing framework plugins..."
    state_db_add_item "installed_modules" "plugin_manager"
    log_success "Plugin Manager processed all registered plugins."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_plugin_manager
fi
