#!/usr/bin/env bash
# Unit Test: OS & Hardware Detection
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/os_detect.sh"

test_os_detect() {
    detect_system
    if [[ -z "${SYS_ARCH}" ]]; then
        echo "[FAIL] SYS_ARCH is empty!" >&2
        exit 1
    fi
    echo "[PASS] OS Detection unit test successful. Arch: ${SYS_ARCH}"
}

test_os_detect
