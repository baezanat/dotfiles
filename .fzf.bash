# Setup fzf
# ---------
if [[ ! "$PATH" == */home/natalia/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/natalia/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/natalia/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/natalia/.fzf/shell/key-bindings.bash"
