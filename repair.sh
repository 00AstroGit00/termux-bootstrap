#!/usr/bin/env bash
# Termux Bootstrap Repair Entrypoint
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "${SCRIPT_DIR}/bootstrap/main.sh" repair "$@"
