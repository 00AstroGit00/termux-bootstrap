# Installation Guide

## Quick Start
Clone or download the repository into your Termux environment and execute the entrypoint:

```bash
git clone https://github.com/termux/termux-bootstrap-v4.git ~/termux-bootstrap-v4
cd ~/termux-bootstrap-v4
./bootstrap.sh
```

## Running Diagnostics & Self-Healing Repair
```bash
# Check system health
./doctor.sh

# Run self-healing repair routines
./repair.sh

# Perform snapshot rollback
./rollback.sh
```
EOF
