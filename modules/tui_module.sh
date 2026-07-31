#!/usr/bin/env bash
# Terminal UI Presentation Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/tui.sh"
source "${SCRIPT_DIR}/lib/logger.sh"

run_tui_module() {
    tui_banner
    tui_card "Termux Bootstrap v4.0" \
        "Modular Enterprise Provisioning Framework" \
        "Idempotent * Transaction Safe * Self Healing"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_tui_module
fi
