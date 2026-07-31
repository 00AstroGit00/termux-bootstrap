#!/usr/bin/env bash
# ==============================================================================
# AI & Machine Learning Environment Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"
source "${SCRIPT_DIR}/lib/os_detect.sh"

run_ai_env() {
    log_section "AI & Local LLM Environment Engine"

    local bin_dir="$HOME/.termux-bootstrap/bin"
    mkdir -p "${bin_dir}"

    detect_system

    # Generate llama-setup.sh helper script for building & running llama.cpp
    cat <<EOF > "${bin_dir}/llama-setup.sh"
#!/usr/bin/env bash
# Termux llama.cpp Installer & Local LLM Runner
set -euo pipefail
echo "[INFO] Initializing llama.cpp build for Termux (${SYS_ARCH})..."
LLAMA_DIR="\$HOME/llama.cpp"
if [[ ! -d "\${LLAMA_DIR}" ]]; then
    git clone https://github.com/ggerganov/llama.cpp "\${LLAMA_DIR}"
fi
cd "\${LLAMA_DIR}"
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j${SYS_CPU_CORES}
echo "[OK] llama.cpp compiled successfully. Run models using ./bin/llama-cli -m <model.gguf> -t ${SYS_CPU_CORES}"
EOF
    chmod +x "${bin_dir}/llama-setup.sh"

    if [[ "${INSTALL_AI:-1}" -eq 1 ]]; then
        log_info "Configuring Python AI dependencies (numpy, requests)..."
        if command -v pip3 >/dev/null 2>&1 || command -v pip >/dev/null 2>&1; then
            pip install --upgrade pip 2>/dev/null || true
            pip install numpy requests 2>/dev/null || true
        fi
        state_db_add_item "installed_modules" "ai_env"
        log_success "AI environment configuration & llama-setup.sh helper created."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_ai_env
fi
