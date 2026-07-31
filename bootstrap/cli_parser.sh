#!/usr/bin/env bash
# ==============================================================================
# CLI Argument & Command Parser
# ==============================================================================

set -euo pipefail

parse_cli_args() {
    COMMAND="${1:-run}"
    if [[ $# -gt 0 ]]; then
        shift
    fi

    DRY_RUN=0
    VERBOSE=0

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)
                DRY_RUN=1
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                shift
                ;;
            -h|--help|help)
                COMMAND="help"
                shift
                ;;
            *)
                shift
                ;;
        esac
    done
}
