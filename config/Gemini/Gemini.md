# Gemini Context & System Instructions

## System Configuration (Aktuální k 6. února 2026)
This file contains persistent system information for the Gemini CLI agent. Use this context to answer questions about the system configuration without asking for repetition.

### Hardware
- **CPU:** Intel Core i7-10850H (Comet Lake-H)
- **RAM:** 32 GB
- **GPU:** Hybrid / Optimus
  - iGPU: Intel UHD Graphics (CometLake-H GT2)
  - dGPU: NVIDIA GeForce GTX 1650 Ti Mobile
- **Chassis:** Laptop (implied by Mobile GPU/CPU)

### Software Environment
- **OS:** Arch Linux (Rolling)
- **Kernel:** Linux 6.18.x
- **Desktop Environment:** KDE Plasma 6 (Wayland)
  - **Version:** Plasma 6.5.5
  - **Session Type:** Wayland
- **Shell:** Bash (`/usr/bin/bash`)
- **Locale:** Czech (cs_CZ)

### Visual Preferences
- **Global Theme:** Breeze Dark
- **Icons:** Breeze Dark

## Instructions for Agent
1. **System Assumptions:** Always assume the user is running Arch Linux with KDE Plasma 6 on Wayland unless specified otherwise.
2. **Package Management:** Use `pacman` (or `yay`/`paru` if detected/requested) for package suggestions.
3. **Configuration:** For UI/Theming queries, refer to KDE Plasma 6 conventions (`kdeglobals`, `plasmarc`).
4. **Language:** The system locale is Czech. Output technical commands in English/Standard, but be aware system output in logs might be in Czech.
