#!/usr/bin/env bash
# ==============================================================================
# Codeberg Mirror & Download Provider
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/download_engine.sh"

codeberg_fetch_raw() {
    local repo="$1"
    local branch="$2"
    local file_path="$3"
    local output_dest="$4"
    local checksum="${5:-SKIP}"

    local url="https://codeberg.org/${repo}/raw/branch/${branch}/${file_path}"

    download_file "${url}" "${output_dest}" "${checksum}" 3
}
