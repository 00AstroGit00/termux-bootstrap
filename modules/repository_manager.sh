#!/usr/bin/env bash
# ==============================================================================
# Repository Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"
source "${SCRIPT_DIR}/lib/yaml_parser.sh"

run_repository_manager() {
    log_section "Repository Manager"

    local manifest_file="${SCRIPT_DIR}/manifests/repositories.yaml"
    if [[ ! -f "${manifest_file}" ]]; then
        log_warn "No repository manifest found at ${manifest_file}"
        return 0
    fi

    log_info "Synchronizing APT repositories (Main, Root, X11, TUR, Glibc)..."

    # Install tur-repo and glibc-repo if available
    if command -v pkg >/dev/null 2>&1; then
        pkg install -y tur-repo glibc-repo 2>/dev/null || true
        log_info "Updating pkg package database index..."
        pkg update -y || apt-get update -y || log_warn "Package database index update encountered warnings."
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get update -y || log_warn "apt-get update encountered warnings."
    else
        log_warn "APT package manager not found. Skipping repo sync."
    fi

    state_db_add_item "installed_modules" "repository_manager"
    log_success "Repository Manager sync completed."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_repository_manager
fi
