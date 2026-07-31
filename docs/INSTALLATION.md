# Installation & Ultra-Short One-Liner Guide

## Fresh Termux Shell (Ultra-Short Single Command)

For a brand new, freshly installed Termux Android environment, execute this 93-character command in your terminal:

```bash
pkg i -y curl && curl -sSL https://raw.githubusercontent.com/00AstroGit00/termux-bootstrap/main/install.sh | bash
```

### Git Clone Method
```bash
pkg update -y && pkg install -y git curl && git clone https://github.com/00AstroGit00/termux-bootstrap.git ~/.termux-bootstrap-framework && cd ~/.termux-bootstrap-framework && ./bootstrap.sh
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
