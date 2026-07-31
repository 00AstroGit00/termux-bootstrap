# Ultimate Production-Grade Termux Bootstrap Framework v4.0

A modular, manifest-driven, transaction-safe, self-healing, idempotent provisioning framework for Termux environments on Android.

---

## Features
- **Production Ready & Modular**: Clean separation between standard libraries (`lib/`), domain modules (`modules/`), and CLI wrappers.
- **Idempotent & Transaction Safe**: State tracking via `$HOME/.termux-bootstrap/state/db.json` with pre-execution snapshots and one-command rollback (`./rollback.sh`).
- **Self-Healing Doctor & Repair**: Diagnostics suite (`./doctor.sh`) and auto-repair routines (`./repair.sh`) for APT databases, broken symlinks, and file permissions.
- **Manifest Engine**: Declarative YAML manifests (`packages.yaml`, `repositories.yaml`, `installers.yaml`) with priorities, architectures, and fallback mirrors.
- **Multi-Mirror Resilient Download Engine**: Supports GitHub, GitLab, Codeberg, and Local Cache providers with SHA256 checksum verification and retry backoff.
- **Structured Logging & Reporting**: Multi-channel logging (ANSI stdout, JSON Lines telemetry, Markdown summaries) and automated generation of 6 system reports under `reports/`.
- **Automated Test Suite**: Complete unit and integration test runner (`./tests/run_tests.sh`).

---

## Directory Architecture
```
termux-bootstrap-v4/
├── bootstrap.sh                 # Standard entrypoint wrapper
├── doctor.sh                    # Diagnostic CLI wrapper
├── repair.sh                    # Auto-heal repair CLI wrapper
├── rollback.sh                  # Rollback manager CLI wrapper
├── update.sh                    # Self-updater CLI wrapper
├── config.env                   # Configuration settings
├── bootstrap/                   # Main CLI engine & parser
├── lib/                         # Standard foundation libraries
├── modules/                     # Isolated domain modules
├── manifests/                   # Declarative YAML manifests
├── providers/                   # Download & mirror providers
├── installers/                  # Custom installer adapters
├── doctor/                      # System diagnostic checks
├── repair/                      # Auto-healing repair routines
├── rollback/                    # Snapshot restoration engine
├── reports/                     # Telemetry reports
├── tests/                       # Automated test suite
└── docs/                        # Technical documentation suite
```

---

## Quick Usage

```bash
# Execute full provisioning pipeline
./bootstrap.sh

# Run system diagnostic checks
./doctor.sh

# Run self-healing repair routines
./repair.sh

# Restore system state from latest snapshot
./rollback.sh

# Execute automated test suite
./tests/run_tests.sh
```

---

## License
MIT License - See `LICENSE` for details.
EOF
