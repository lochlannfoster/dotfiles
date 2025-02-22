# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Add /usr/sbin and /sbin if not already present
if [[ ":$PATH:" != *":/usr/sbin:"* ]]; then
    PATH="$PATH:/usr/sbin"
fi

if [[ ":$PATH:" != *":/sbin:"* ]]; then
    PATH="$PATH:/sbin"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

_RED=$(tput setaf 1)
_BLUE=$(tput setaf 4)
_CYAN=$(tput setaf 6)
_WHITE=$(tput setaf 7)
_BOLD=$(tput bold)
_RESET=$(tput sgr0)

# Underline on/off
_UNDERLINE=$(tput smul)
_NOUNDLINE=$(tput rmul)

# Define additional vibrant colours for our prompt
_VIVID_PINK=$(tput setaf 213)
_VIVID_ORANGE=$(tput setaf 208)

export PS1="\
\[${_BOLD}${_WHITE}\]>"\
"$EXIT_STATUS"\
"\[${_UNDERLINE}${_RED}\]\u"\
"\[${_UNDERLINE}${_BOLD}${_WHITE}\]@"\
"\[${_UNDERLINE}${_BLUE}\]\h"\
"\[${_NOUNDLINE}${_BOLD}${_WHITE}\]]"\
"\[${_VIVID_ORANGE}\](\@)"\
"\[${_BOLD}${_WHITE}\]:"\
"\[${_CYAN}\]\w"\
" \$(parse_git_branch)"\
"\[${_BOLD}${_WHITE}\]\$"\
"\[${_RESET}\] "

# Make Git branch show in prompt:
# Function to extract the current Git branch
parse_git_branch() {
    git branch 2>/dev/null | sed -n '/\* /s///p'
}

# DIsplay last command's exit status
# # Add a variable to hold the exit status symbol
EXIT_STATUS=""

# A function to set the exit status indicator before each prompt is displayed
set_exit_status() {
    if [[ $? -eq 0 ]]; then
        EXIT_STATUS=""
    else
        # Show a red "✖" if the last command failed.
        EXIT_STATUS="\[${_RED}\]✖\[${_RESET}\] "
    fi
}

PROMPT_COMMAND=set_exit_status

# At the end of ~/.bashrc
~/motd.sh

