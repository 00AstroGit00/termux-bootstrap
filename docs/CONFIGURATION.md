# Configuration Guide & Profile Customization

Configuration variables are stored in `config.env` and declarative YAML files in `manifests/`.

## Environment Profiles (`examples/profiles/`)
- `examples/profiles/minimal.env`: Resource-friendly profile for low-spec Android devices.
- `examples/profiles/full-developer.env`: Full workstation profile enabling X11, proot-distro, AI toolchains, and modern CLI tools.

## Nerd Fonts & Terminal Icon Rendering
To ensure icons from `starship`, `eza`, `fastfetch`, and `btop` render properly:
1. Download a Nerd Font (such as `MesloLGS NF` or `FiraCode Nerd Font`).
2. Set the custom font in your Termux Terminal Styling preferences or Termux:GUI settings.
EOF
