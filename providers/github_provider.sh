#!/usr/bin/env bash
# ==============================================================================
# GitHub Mirror & Download Provider
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/download_engine.sh"

github_fetch_raw() {
    local repo="$1"       # e.g., "owner/repo"
    local branch="$2"     # e.g., "main" or "master"
    local file_path="$3"  # e.g., "scripts/install.sh"
    local output_dest="$4"
    local checksum="${5:-SKIP}"

    local url="https://raw.githubusercontent.com/${repo}/${branch}/${file_path}"
    local fallback="https://cdn.jsdelivr.net/gh/${repo}@${branch}/${file_path}"

    download_file "${url}" "${output_dest}" "${checksum}" 3 "${fallback}"
}
