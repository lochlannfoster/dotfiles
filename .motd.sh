#!/bin/bash
# motd.sh
# Displays a single-line MOTD that spans the full width of the terminal.
# The message consists of a header and a welcome message, separated by a pipe.
# The output is colored in 0x1AFF00 (fluro green).

# --- Duplicate Display Prevention ---
if [ -n "$MOTD_SHOWN" ]; then
    exit 0
fi
export MOTD_SHOWN=1

# ANSI escape codes for our desired color and reset:
GREEN_FOREGROUND="\e[38;2;26;255;0m"
RESET_COLOR="\e[0m"

# --- Get Terminal Width ---
term_width=$(tput cols)

# --- Define Message Components ---
header="THINKCHADS"
welcome="Welcome to $(hostname), $(whoami). Enjoy your stay!"

# Combine with a delimiter; adjust as needed.
message="$header | $welcome"
msg_length=${#message}

# --- Calculate Padding ---
if [ "$msg_length" -lt "$term_width" ]; then
    pad_length=$(( term_width - msg_length ))
else
    pad_length=0
fi
padding=$(printf "%${pad_length}s")

# --- Assemble Final Message ---
final_message="$message$padding"

# --- Display the MOTD in fluro green ---
echo -e "${GREEN_FOREGROUND}${final_message}${RESET_COLOR}"

