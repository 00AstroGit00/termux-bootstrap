#!/usr/bin/env bash
# Integration Test: Snapshot Creation & Rollback Restoration
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

test_rollback_recovery() {
    echo "Testing snapshot creation and rollback recovery..."
    bash "${SCRIPT_DIR}/modules/backup_manager.sh"
    bash "${SCRIPT_DIR}/rollback.sh"
    echo "[PASS] Rollback recovery integration test completed successfully."
}

test_rollback_recovery
