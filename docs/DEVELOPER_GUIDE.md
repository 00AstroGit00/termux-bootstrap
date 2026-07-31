# Developer & Contributor Guide

## Code Conventions & Standards
1. Use `set -euo pipefail` in all shell scripts.
2. Source foundation libraries (`lib/logger.sh`, `lib/state_db.sh`) at the start of modules.
3. Keep modules isolated and idempotent.
4. Ensure all unit and integration tests pass via `./tests/run_tests.sh`.
EOF
