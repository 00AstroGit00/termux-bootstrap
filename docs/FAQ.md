# Frequently Asked Questions (FAQ)

### Q: Is Termux Bootstrap v4.0 idempotent?
A: Yes. Re-running `./bootstrap.sh` will evaluate existing packages and configurations without redundant actions or broken states.

### Q: How does rollback work?
A: Before any system modification, `backup_manager.sh` creates a timestamped snapshot of state databases and configurations under `$HOME/.termux-bootstrap/snapshots/`. Running `./rollback.sh` restores the latest snapshot.

### Q: Can I run this offline?
A: Yes. If network connectivity is unavailable, the framework utilizes local offline cache providers under `cache/`.
EOF
