#!/usr/bin/env bash
# Unit Test: State Database
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export BOOTSTRAP_STATE_DIR="${SCRIPT_DIR}/cache/test_state"
rm -rf "${BOOTSTRAP_STATE_DIR}"

source "${SCRIPT_DIR}/lib/state_db.sh"

test_state_db() {
    state_db_init
    state_db_set_key "test_key" "test_value"
    local val
    val=$(state_db_get_key "test_key")
    if [[ "${val}" != "test_value" ]]; then
        echo "[FAIL] Expected test_value, got ${val}" >&2
        exit 1
    fi

    state_db_add_item "installed_packages" "zsh"
    echo "[PASS] State Database unit test successful."
    rm -rf "${BOOTSTRAP_STATE_DIR}"
}

test_state_db
