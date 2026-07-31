# Installation & One-Liner Execution Guide

## Fresh Termux Shell (Single Command Installation)

For a brand new, freshly installed Termux Android environment, execute the following one-liner in your terminal:

```bash
pkg update -y && pkg install -y git curl && git clone https://github.com/00AstroGit00/termux-bootstrap.git ~/.termux-bootstrap-framework && cd ~/.termux-bootstrap-framework && ./bootstrap.sh
```

### Release Archive Method
If `git` is unavailable or you prefer a tarball distribution release:

```bash
pkg update -y && pkg install -y curl tar && mkdir -p ~/.termux-bootstrap-framework && curl -sSL https://github.com/00AstroGit00/termux-bootstrap/releases/download/v1.0.0/termux-bootstrap-v1.0.0.tar.gz | tar -xzf - -C ~/.termux-bootstrap-framework && cd ~/.termux-bootstrap-framework && ./bootstrap.sh
```

---

## Running Diagnostics & Repair Commands

```bash
# Check system health
./doctor.sh

# Run self-healing repair routines
./repair.sh

# Perform snapshot rollback
./rollback.sh
```
EOF
