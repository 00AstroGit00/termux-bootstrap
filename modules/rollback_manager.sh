#!/usr/bin/env bash
# ==============================================================================
# Rollback Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

SNAPSHOT_DIR="${BOOTSTRAP_SNAPSHOT_DIR:-$HOME/.termux-bootstrap/snapshots}"

restore_latest_snapshot() {
    log_section "Rollback Manager"

    if [[ ! -d "${SNAPSHOT_DIR}" ]]; then
        log_error "No snapshot directory found at ${SNAPSHOT_DIR}"
        return 1
    fi

    local latest_snap
    latest_snap=$(ls -td "${SNAPSHOT_DIR}"/snap_* 2>/dev/null | head -n 1 || echo "")

    if [[ -z "${latest_snap}" || ! -d "${latest_snap}" ]]; then
        log_error "No snapshots available to perform rollback!"
        return 1
    fi

    log_warn "Restoring environment from latest snapshot: $(basename "${latest_snap}")"

    if [[ -d "${latest_snap}/state" ]]; then
        cp -r "${latest_snap}/state/"* "$HOME/.termux-bootstrap/state/" 2>/dev/null || true
    fi

    if [[ -f "${latest_snap}/zshrc.bak" ]]; then
        cp "${latest_snap}/zshrc.bak" "$HOME/.zshrc" 2>/dev/null || true
    fi

    state_db_record_event "rollback_restore" "$(basename "${latest_snap}")" "SUCCESS"
    log_success "Rollback restored successfully from ${latest_snap}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    restore_latest_snapshot
fi
