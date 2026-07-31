#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Terminal UI & Visual Helper Module
# ==============================================================================

set -euo pipefail

tui_banner() {
    cat <<'EOF'
  ______                            ______              __          __                 
 /_  __/___  ______  ____  __  YX  / __/ /_  ____  ____/ /__________/ /__________ _____ 
  / / / _ \/ ___/ \/ / / / / \/ /  / /_/ __ \/ __ \/ __  / ___/ ___/ __/ ___/ __ `/ __ \
 / / /  __/ /  / / / /_/ / /   /  / __/ /_/ / /_/ / /_/ (__  ) /__/ /_/ /  / /_/ / /_/ /
/_/  \___/_/  /_/ /_/\__,_/_/\_/  /_/ /_.___/\____/\__,_/____/\___/\__/_/   \__,_/ .___/ 
                                                                                /_/      
EOF
}

tui_card() {
    local title="$1"
    shift
    local width=60

    printf "+%s+\n" "$(printf '=%.0s' $(seq 1 $width))"
    printf "| %-58s |\n" "${title}"
    printf "+%s+\n" "$(printf '-%.0s' $(seq 1 $width))"
    for line in "$@"; do
        printf "| %-58s |\n" "${line}"
    done
    printf "+%s+\n\n" "$(printf '=%.0s' $(seq 1 $width))"
}

tui_progress() {
    local current="$1"
    local total="$2"
    local label="${3:-Progress}"

    local percent=$(( current * 100 / total ))
    local completed=$(( percent / 5 ))
    local remaining=$(( 20 - completed ))

    local bar=""
    if [[ $completed -gt 0 ]]; then
        bar=$(printf '#%.0s' $(seq 1 $completed))
    fi
    if [[ $remaining -gt 0 ]]; then
        bar="${bar}$(printf '-%.0s' $(seq 1 $remaining))"
    fi

    printf "\r[%s] [%s] %3d%% (%d/%d)" "${label}" "${bar}" "${percent}" "${current}" "${total}"
    if [[ "${current}" -eq "${total}" ]]; then
        echo ""
    fi
}
