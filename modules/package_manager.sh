#!/usr/bin/env bash
# ==============================================================================
# Package Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_package_manager() {
    log_section "Package Manager"

    local core_txt="${SCRIPT_DIR}/manifests/packages-core.txt"
    local pkgs=()

    if [[ -f "${core_txt}" ]]; then
        while IFS= read -r line || [[ -n "${line}" ]]; do
            # Skip comments and empty lines
            line=$(echo "${line}" | sed 's/#.*//' | tr -d ' \r\t')
            if [[ -n "${line}" ]]; then
                pkgs+=("${line}")
            fi
        done < "${core_txt}"
    fi

    log_info "Evaluating core package dependencies: ${pkgs[*]:-none}"

    local to_install=()
    for pkg in "${pkgs[@]}"; do
        if command -v dpkg >/dev/null 2>&1 && dpkg -l "${pkg}" >/dev/null 2>&1; then
            log_debug "Package ${pkg} is already installed."
            state_db_add_item "installed_packages" "${pkg}"
        else
            to_install+=("${pkg}")
        fi
    done

    if [[ ${#to_install[@]} -gt 0 ]]; then
        log_info "Installing missing packages: ${to_install[*]}"
        if command -v pkg >/dev/null 2>&1; then
            pkg install -y "${to_install[@]}" || apt-get install -y "${to_install[@]}"
        elif command -v apt-get >/dev/null 2>&1; then
            apt-get install -y "${to_install[@]}"
        fi

        for pkg in "${to_install[@]}"; do
            state_db_add_item "installed_packages" "${pkg}"
        done
        log_success "Packages successfully installed."
    else
        log_success "All declared core packages are already present."
    fi

    state_db_add_item "installed_modules" "package_manager"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_package_manager
fi
