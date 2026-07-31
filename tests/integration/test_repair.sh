#!/usr/bin/env bash
# Integration Test: Repair CLI Execution
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

test_repair_cli() {
    echo "Running Repair CLI integration test..."
    bash "${SCRIPT_DIR}/repair.sh"
    echo "[PASS] Repair integration test completed successfully."
}

test_repair_cli
