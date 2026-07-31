# Migration Guide from Legacy Bootstrap (v1-v3) to v4.0

## Migration Overview
Termux Bootstrap v4.0 introduces a modular, manifest-driven engine.

1. **Manifests**: Replace hardcoded `apt install` scripts with `manifests/packages.yaml`.
2. **Installers**: Move inline installer scripts into `installers/*.sh` adapters.
3. **Database**: Legacy lockfiles and state tracking are automatically migrated into `$HOME/.termux-bootstrap/state/db.json`.
EOF
