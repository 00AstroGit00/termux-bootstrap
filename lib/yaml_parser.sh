#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Manifest & YAML Parser Engine
# ==============================================================================
# Provides robust parsing for YAML files using native AWK fallbacks or
# python3 / yq / jq when available.
# ==============================================================================

set -euo pipefail

parse_yaml_key() {
    local file="$1"
    local key="$2"
    local default_val="${3:-}"

    if [[ ! -f "${file}" ]]; then
        echo "${default_val}"
        return 0
    fi

    # Try yq if installed
    if command -v yq >/dev/null 2>&1; then
        local val
        val=$(yq e ".${key} // empty" "${file}" 2>/dev/null || true)
        if [[ -n "${val}" && "${val}" != "null" ]]; then
            echo "${val}"
            return 0
        fi
    fi

    # Try python3 if installed
    if command -v python3 >/dev/null 2>&1; then
        local py_val
        py_val=$(python3 -c "
import sys, yaml
try:
    with open('${file}', 'r') as f:
        data = yaml.safe_load(f)
    keys = '${key}'.split('.')
    res = data
    for k in keys:
        if isinstance(res, dict):
            res = res.get(k)
        else:
            res = None
            break
    if res is not None:
        print(res)
except Exception:
    pass
" 2>/dev/null || true)
        if [[ -n "${py_val}" && "${py_val}" != "None" ]]; then
            echo "${py_val}"
            return 0
        fi
    fi

    # Fallback AWK simple parser for root key: value
    awk -v target_key="${key}" -v def="${default_val}" '
    BEGIN { FS=":"; found=0 }
    /^[[:space:]]*#/ { next }
    /^[[:space:]]*$/ { next }
    {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", $1)
        if ($1 == target_key) {
            val = substr($0, index($0, ":") + 1)
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
            gsub(/^["'\''"]|["'\''"]$/, "", val)
            print val
            found=1
            exit
        }
    }
    END {
        if (!found) print def
    }
    ' "${file}"
}

# Extracts items from a list field in YAML, e.g. packages list or array entries
parse_yaml_list() {
    local file="$1"
    local section="$2"

    if [[ ! -f "${file}" ]]; then
        return 0
    fi

    # Fallback AWK list reader
    awk -v sec="${section}" '
    BEGIN { in_sec=0 }
    /^[[:space:]]*#/ { next }
    $0 ~ "^" sec ":" { in_sec=1; next }
    in_sec && /^[a-zA-Z0-9_-]+:/ { in_sec=0 }
    in_sec && /^[[:space:]]*-[[:space:]]+/ {
        line = $0
        sub(/^[[:space:]]*-[[:space:]]+/, "", line)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
        gsub(/^["'\''"]|["'\''"]$/, "", line)
        if (length(line) > 0) print line
    }
    ' "${file}"
}
