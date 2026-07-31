#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - State Database Manager
# ==============================================================================

set -euo pipefail

STATE_DIR="${BOOTSTRAP_STATE_DIR:-$HOME/.termux-bootstrap/state}"
STATE_DB="${STATE_DIR}/db.json"

state_db_init() {
    (umask 077 && mkdir -p "${STATE_DIR}")
    if [[ ! -f "${STATE_DB}" ]]; then
        (
            umask 077
            cat <<'EOF' > "${STATE_DB}"
{
  "version": "4.0.0",
  "initialized_at": "",
  "last_run": "",
  "installed_packages": [],
  "installed_modules": [],
  "installed_installers": [],
  "repositories": [],
  "history": []
}
EOF
        )
        local ts
        ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date)
        state_db_set_key "initialized_at" "${ts}"
    fi
}

state_db_get_key() {
    local key="$1"
    state_db_init
    if command -v jq >/dev/null 2>&1; then
        jq -r ".${key} // empty" "${STATE_DB}" 2>/dev/null || echo ""
    else
        grep -E "\"${key}\":" "${STATE_DB}" 2>/dev/null | cut -d':' -f2 | tr -d '", ' || echo ""
    fi
}

state_db_set_key() {
    local key="$1"
    local value="$2"
    state_db_init

    if command -v jq >/dev/null 2>&1; then
        local tmp_db="${STATE_DB}.tmp"
        jq --arg k "${key}" --arg v "${value}" '.[$k] = $v' "${STATE_DB}" > "${tmp_db}" && mv "${tmp_db}" "${STATE_DB}"
    else
        sed -i "s/\"${key}\": \".*\"/\"${key}\": \"${value}\"/" "${STATE_DB}" 2>/dev/null || true
    fi
}

state_db_add_item() {
    local list_key="$1"
    local item="$2"
    state_db_init

    if command -v jq >/dev/null 2>&1; then
        local tmp_db="${STATE_DB}.tmp"
        jq --arg l "${list_key}" --arg i "${item}" '
            if (.[$l] | index($i)) == null then
                .[$l] += [$i]
            else
                .
            end
        ' "${STATE_DB}" > "${tmp_db}" && mv "${tmp_db}" "${STATE_DB}"
    else
        if ! grep -q "\"${item}\"" "${STATE_DB}" 2>/dev/null; then
            (umask 077 && echo "${item}" >> "${STATE_DIR}/${list_key}.txt")
        fi
    fi
}

state_db_has_item() {
    local list_key="$1"
    local item="$2"
    state_db_init

    if command -v jq >/dev/null 2>&1; then
        jq -e --arg l "${list_key}" --arg i "${item}" '.[$l] | index($i) != null' "${STATE_DB}" >/dev/null 2>&1
    else
        if [[ -f "${STATE_DIR}/${list_key}.txt" ]]; then
            grep -q "^${item}$" "${STATE_DIR}/${list_key}.txt" 2>/dev/null
        else
            grep -q "\"${item}\"" "${STATE_DB}" 2>/dev/null
        fi
    fi
}

state_db_record_event() {
    local action="$1"
    local target="$2"
    local status="${3:-SUCCESS}"
    local ts
    ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date)

    state_db_init
    if command -v jq >/dev/null 2>&1; then
        local tmp_db="${STATE_DB}.tmp"
        jq --arg ts "${ts}" --arg act "${action}" --arg tgt "${target}" --arg st "${status}" '
            .history += [{"timestamp": $ts, "action": $act, "target": $tgt, "status": $st}]
        ' "${STATE_DB}" > "${tmp_db}" && mv "${tmp_db}" "${STATE_DB}"
    fi
    state_db_set_key "last_run" "${ts}"
}
