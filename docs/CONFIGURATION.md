# Configuration Guide

Configuration variables are stored in `config.env` and declarative YAML files in `manifests/`.

## `config.env` Options
- `INSTALL_X11`: Set to `1` to enable Termux:X11 display server packages.
- `INSTALL_PROOT`: Set to `1` to enable proot-distro Linux guest environments.
- `INSTALL_AI`: Set to `1` to enable AI environment packages.

## Manifest Configuration
- `manifests/packages.yaml`: Core and optional package definitions.
- `manifests/repositories.yaml`: Mirror sources and APT components.
- `manifests/installers.yaml`: Custom installer adapters and download URLs.
EOF
