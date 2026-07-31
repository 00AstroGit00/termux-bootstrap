#!/usr/bin/env bash
# Integration Test: Doctor CLI Execution
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

test_doctor_cli() {
    echo "Running Doctor CLI integration test..."
    bash "${SCRIPT_DIR}/doctor.sh"
    echo "[PASS] Doctor integration test completed successfully."
}

test_doctor_cli
