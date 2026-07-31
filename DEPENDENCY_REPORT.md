# Termux Bootstrap Framework v1.0.0 - Dependency & Mirror Inventory Report

## 1. Dependency Inventory

| Package / Tool | Status | Min API | Category | License |
|----------------|--------|---------|----------|---------|
| `bash` | Mandatory | 24 | Shell Core | GPL-3.0 |
| `git` | Mandatory | 24 | Version Control | GPL-2.0 |
| `curl` / `wget` | Mandatory | 24 | Download Engine | MIT / GPL-3.0 |
| `openssh` | Core | 24 | SSH Daemon | BSD |
| `termux-services` | Core | 24 | Service Manager | Apache-2.0 |
| `zsh` | Core | 24 | Default Shell | MIT |
| `jq` | Optional | 24 | JSON Parser | MIT |
| `proot-distro` | Optional | 24 | Containers | GPL-3.0 |

---

## 2. Mirror Provider Status

| Provider ID | URL | Health Check | Fallback Status |
|-------------|-----|--------------|-----------------|
| GitHub Raw | `raw.githubusercontent.com` | ONLINE | Primary |
| GitLab Raw | `gitlab.com` | ONLINE | Secondary |
| Codeberg Raw | `codeberg.org` | ONLINE | Tertiary |
| Local Offline Cache | `$HOME/.termux-bootstrap/cache` | LOCAL | Offline Guard |
EOF
