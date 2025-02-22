#!/bin/bash
# motd.sh
# Displays a three-line MOTD in fluro green (0x1AFF00).
# Lines:
# 1. Header: "THINKCHADS"
# 2. Tagline: "I THINKPAD, THEREFORE I CHAD"
# 3. Welcome message with hostname and username.

# --- Duplicate Display Prevention ---
if [ -n "$MOTD_SHOWN" ]; then
    exit 0
fi
export MOTD_SHOWN=1

# ANSI escape codes for fluro green and reset:
GREEN="\e[38;2;26;255;0m"
RESET="\e[0m"

# Define message components:
header=">THINKCHADS"
tagline=">'I THINKPAD, THEREFORE I THINKCHAD'"
welcome=">Welcome to $(hostname), $(whoami). Enjoy your stay!"

# Assemble the MOTD as three lines:
motd="${header}\n${tagline}\n${welcome}"

# Print the MOTD in green:
echo -e "${GREEN}${motd}${RESET}"

