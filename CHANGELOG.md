# CHANGELOG

## [4.0.0] - 2026-07-31

### Added
- **Modular CLI Architecture**: Added `bootstrap/main.sh` orchestrator and subcommands (`run`, `doctor`, `repair`, `rollback`, `update`, `report`, `benchmark`).
- **Foundation Standard Libraries**: `lib/logger.sh`, `lib/os_detect.sh`, `lib/yaml_parser.sh`, `lib/state_db.sh`, `lib/lock_manager.sh`, `lib/crypto_verifier.sh`, `lib/download_engine.sh`, `lib/tui.sh`.
- **Declarative Manifest Engine**: Added `manifests/packages.yaml`, `manifests/repositories.yaml`, `manifests/installers.yaml`, `manifests/plugins.yaml`, `manifests/services.yaml`.
- **Provider Mirrors**: Added GitHub, GitLab, Codeberg, and Local Cache providers.
- **Doctor Diagnostics & Repair**: Added `doctor/` diagnostic suite and `repair/` self-healing routines.
- **Transaction Snapshots & Rollback**: Added snapshot manager with timestamped restore points.
- **Automated Test Suite**: Added `tests/run_tests.sh` covering unit and integration tests.
- **Complete Documentation Suite**: Added `docs/` with architecture, installation, developer, plugin, and troubleshooting guides.
EOF
