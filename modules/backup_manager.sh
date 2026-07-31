#!/usr/bin/env bash
# ==============================================================================
# Backup Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

SNAPSHOT_DIR="${BOOTSTRAP_SNAPSHOT_DIR:-$HOME/.termux-bootstrap/snapshots}"

create_backup_snapshot() {
    local label="${1:-pre_execution}"
    local ts
    ts=$(date +"%Y%m%d_%H%M%S")
    local snap_id="snap_${label}_${ts}"
    local snap_path="${SNAPSHOT_DIR}/${snap_id}"

    log_info "Creating rollback backup snapshot: ${snap_id}"
    mkdir -p "${snap_path}"

    if [[ -d "$HOME/.termux-bootstrap/state" ]]; then
        cp -r "$HOME/.termux-bootstrap/state" "${snap_path}/" 2>/dev/null || true
    fi

    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "${snap_path}/zshrc.bak" 2>/dev/null || true
    fi

    state_db_record_event "create_backup" "${snap_id}" "SUCCESS"
    log_success "Backup snapshot created at ${snap_path}"
    echo "${snap_path}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    create_backup_snapshot "manual"
fi
