# Release Process & Engineering Manual

## Release Cadence & Semantic Versioning
We adhere to [Semantic Versioning 2.0.0](https://semver.org/) (`MAJOR.MINOR.PATCH`).

## Release Checklist
1. Verify all unit and integration tests pass:
   ```bash
   bash tests/run_tests.sh
   ```
2. Verify static analysis compliance:
   ```bash
   shellcheck -x *.sh bootstrap/*.sh lib/*.sh modules/*.sh installers/*.sh providers/*.sh doctor/*.sh repair/*.sh
   ```
3. Update `CHANGELOG.md` and bump version tag.
4. Package distribution archive and generate SHA-256 checksums:
   ```bash
   tar -czvf termux-bootstrap-v1.0.0.tar.gz --exclude='.git' .
   sha256sum termux-bootstrap-v1.0.0.tar.gz > termux-bootstrap-v1.0.0.tar.gz.sha256
   ```
5. Tag and publish GitHub Release:
   ```bash
   gh release create v1.0.0 termux-bootstrap-v1.0.0.tar.gz termux-bootstrap-v1.0.0.tar.gz.sha256 --title "Termux Bootstrap v1.0.0" --notes-file RELEASE_NOTES.md
   ```
EOF
