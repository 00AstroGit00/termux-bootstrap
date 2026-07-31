# Troubleshooting & Diagnostics

## Common Issues & Solutions

### 1. APT Lock Errors
If APT fails due to lock file errors, run the self-healing repair tool:
```bash
./repair.sh
```

### 2. Checksum Verification Failure
Ensure network connection is stable or update the expected hash in `manifests/installers.yaml`.

### 3. Broken Shell Configurations
To restore your default shell environment, perform a rollback:
```bash
./rollback.sh
```
EOF
