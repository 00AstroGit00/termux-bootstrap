# Module Guide & Architecture

Each module under `modules/` handles a single domain:
- `repository_manager.sh`: Manages APT mirrors and sources list.
- `package_manager.sh`: Evaluates and installs core/manifest packages.
- `installer_manager.sh`: Runs third-party custom installers.
- `git_manager.sh`: Manages Git defaults.
- `ssh_manager.sh`: Manages SSH keypairs.
- `storage_manager.sh`: Manages Termux storage permissions.
- `shell_manager.sh`: Manages default shell and zsh profiles.
- `backup_manager.sh`: Creates timestamped restore snapshots.
- `rollback_manager.sh`: Restores system state from snapshots.
- `doctor_module.sh`: Diagnostics suite aggregator.
- `repair_module.sh`: Auto-healing repair suite aggregator.
- `reporting_module.sh`: Generates Markdown telemetry reports.
EOF
