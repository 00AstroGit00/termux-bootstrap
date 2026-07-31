# Changelog

All notable changes to the **Termux Bootstrap Framework** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- Native Termux:GUI graphical status dashboard planning.

---

## [1.0.0] - 2026-07-31

### Added
- **Declarative YAML Manifest Engine**: Schema validation (`manifest_validator.sh`) for packages, repositories, installers, and plugins.
- **Transaction Safety & Self-Healing**: Automated process locking (`lock_manager.sh`), backup snapshots (`backup_manager.sh`), and rollback restoration (`rollback_manager.sh`).
- **Doctor & Diagnostic Suite**: 5 diagnostic modules (`network_check.sh`, `apt_check.sh`, `storage_check.sh`, `permissions_check.sh`, `environment_check.sh`).
- **Modern 2026 CLI Utilities**: Integrated `fastfetch`, `starship`, `eza`, `ripgrep`, `fd`, `fzf`, `zoxide`, `bat`, `lazygit`, `btop`.
- **Termux:X11 & Audio Engine**: Launcher scripts `start-x11.sh` and `start-audio.sh` for PulseAudio TCP audio routing.
- **Mobile AI Inferencing Engine**: Support for `ollama`, `python-pip`, and `llama-setup.sh` native builder.
- **Termux:Boot Device Automation**: Automatic startup hook creation with `termux-wake-lock` guard.
- **Extended Repository Management**: Integrated TUR (Termux User Repository) and Termux Glibc compatibility repos.
- **Remote Web Installer**: One-liner installer `install.sh` for single-command curl deployment.

### Security
- Standardized `umask 077` on state DB and process lock files.
- SHA256 cryptographic verification for package assets (`crypto_verifier.sh`).
- OpenSSF compliant `SECURITY.md` with Safe Harbor guarantees.
EOF
