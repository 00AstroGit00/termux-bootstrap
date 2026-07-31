#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Multi-Channel Structured Logger Module
# ==============================================================================
# Provides leveled logging to stdout/stderr (with optional ANSI colors),
# JSON lines file loggers for telemetry, and Markdown formatted summaries.
# ==============================================================================

set -euo pipefail

# Log levels
LOG_LEVEL_DEBUG=0
LOG_LEVEL_INFO=1
LOG_LEVEL_WARN=2
LOG_LEVEL_ERROR=3
LOG_LEVEL_SUCCESS=4

CURRENT_LOG_LEVEL=${BOOTSTRAP_LOG_LEVEL:-1}
LOG_DIR="${BOOTSTRAP_LOG_DIR:-$HOME/.termux-bootstrap/logs}"
LOG_FILE_TEXT="${LOG_DIR}/bootstrap.log"
LOG_FILE_JSON="${LOG_DIR}/bootstrap.jsonl"
LOG_FILE_MD="${LOG_DIR}/bootstrap.md"

# ANSI Color Definitions
COLOR_RESET="\033[0m"
COLOR_BOLD="\033[1m"
COLOR_DIM="\033[2m"
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_MAGENTA="\033[35m"
COLOR_CYAN="\033[36m"

# Ensure log directory exists
logger_init() {
    mkdir -p "${LOG_DIR}"
    if [[ ! -f "${LOG_FILE_TEXT}" ]]; then
        touch "${LOG_FILE_TEXT}"
    fi
    if [[ ! -f "${LOG_FILE_JSON}" ]]; then
        touch "${LOG_FILE_JSON}"
    fi
}

_timestamp_iso() {
    date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ"
}

_timestamp_human() {
    date +"%Y-%m-%d %H:%M:%S" 2>/dev/null || date
}

# General output formatter
log_msg() {
    local level_num="$1"
    local level_str="$2"
    local color="$3"
    local prefix="$4"
    shift 4
    local msg="$*"

    logger_init

    local ts_iso
    ts_iso="$(_timestamp_iso)"
    local ts_human
    ts_human="$(_timestamp_human)"

    # Write to text log file
    echo "[${ts_iso}] [${level_str}] ${msg}" >> "${LOG_FILE_TEXT}"

    # Write to JSON lines log file
    local json_msg
    json_msg=$(printf '{"timestamp":"%s","level":"%s","message":"%s"}' \
        "${ts_iso}" "${level_str}" "$(echo "${msg}" | sed 's/"/\\"/g')")
    echo "${json_msg}" >> "${LOG_FILE_JSON}"

    # Check level verbosity for stdout
    if (( level_num >= CURRENT_LOG_LEVEL )); then
        if [[ -t 1 && "${BOOTSTRAP_NO_COLOR:-0}" -eq 0 ]]; then
            printf "${color}${prefix} [%s] %b${COLOR_RESET}\n" "${ts_human}" "${msg}"
        else
            printf "%s [%s] %s\n" "${prefix}" "${ts_human}" "${msg}"
        fi
    fi
}

log_debug() {
    log_msg "${LOG_LEVEL_DEBUG}" "DEBUG" "${COLOR_DIM}${COLOR_CYAN}" "[DEBUG]" "$@"
}

log_info() {
    log_msg "${LOG_LEVEL_INFO}" "INFO" "${COLOR_CYAN}" "[INFO ]" "$@"
}

log_warn() {
    log_msg "${LOG_LEVEL_WARN}" "WARN" "${COLOR_YELLOW}" "[WARN ]" "$@"
}

log_error() {
    log_msg "${LOG_LEVEL_ERROR}" "ERROR" "${COLOR_RED}" "[ERROR]" "$@" >&2
}

log_success() {
    log_msg "${LOG_LEVEL_SUCCESS}" "SUCCESS" "${COLOR_GREEN}${COLOR_BOLD}" "[OK   ]" "$@"
}

log_section() {
    local title="$*"
    logger_init
    echo -e "\n## ${title} ($(_timestamp_human))\n" >> "${LOG_FILE_MD}"
    if [[ -t 1 && "${BOOTSTRAP_NO_COLOR:-0}" -eq 0 ]]; then
        printf "\n${COLOR_BOLD}${COLOR_MAGENTA}=== %s ===${COLOR_RESET}\n\n" "${title}"
    else
        printf "\n=== %s ===\n\n" "${title}"
    fi
}

log_md() {
    logger_init
    echo "$@" >> "${LOG_FILE_MD}"
}
