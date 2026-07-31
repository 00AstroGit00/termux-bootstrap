# Security Policy

## Reporting a Vulnerability

We take the security of the Termux Bootstrap Framework seriously. If you discover a vulnerability or security issue, please do not open a public issue.

Instead, please send a private security report to:
`security@termux.org` or open a GitHub Security Advisory.

## Security Practices
- All downloads require SHA256/SHA512 checksum verification.
- Sensitive file operations enforce strict `umask 077` file permission masks.
- Pre-execution snapshots allow instant rollback in case of interrupted or unexpected operations.
EOF
