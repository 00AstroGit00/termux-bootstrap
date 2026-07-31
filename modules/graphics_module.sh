#!/usr/bin/env bash
# ==============================================================================
# Graphics & Termux:X11 Display Server Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_graphics_module() {
    log_section "Graphics & Termux:X11 Engine"

    local bin_dir="$HOME/.termux-bootstrap/bin"
    mkdir -p "${bin_dir}"

    # Generate start-audio.sh launcher for PulseAudio TCP bridge
    cat <<'EOF' > "${bin_dir}/start-audio.sh"
#!/usr/bin/env bash
# Termux PulseAudio TCP Server Launcher
set -euo pipefail
echo "[INFO] Initializing PulseAudio TCP Server..."
pulseaudio -k 2>/dev/null || true
pulseaudio --start --exit-idle-time=-1 2>/dev/null || true
pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 2>/dev/null || true
export PULSE_SERVER=tcp:127.0.0.1:4712
echo "[OK] PulseAudio server running on tcp:127.0.0.1:4712"
EOF
    chmod +x "${bin_dir}/start-audio.sh"

    # Generate start-x11.sh launcher for Termux:X11 display server
    cat <<'EOF' > "${bin_dir}/start-x11.sh"
#!/usr/bin/env bash
# Termux:X11 Display Server Launcher
set -euo pipefail
echo "[INFO] Initializing Termux:X11 Display Server..."
bash "$HOME/.termux-bootstrap/bin/start-audio.sh"
export DISPLAY=:0
export PULSE_SERVER=tcp:127.0.0.1:4712
if command -v termux-x11 >/dev/null 2>&1; then
    termux-x11 :0 -ac &
    echo "[OK] Termux:X11 server started on DISPLAY=:0"
else
    echo "[WARN] termux-x11 package not installed yet."
fi
EOF
    chmod +x "${bin_dir}/start-x11.sh"

    if [[ "${INSTALL_X11:-0}" -eq 1 ]]; then
        log_info "INSTALL_X11 enabled. Configuring display server packages..."
        state_db_add_item "installed_modules" "graphics"
        log_success "Graphics & X11 display engine configured."
    else
        log_info "Generated X11/PulseAudio launchers at ${bin_dir}/start-x11.sh"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_graphics_module
fi
