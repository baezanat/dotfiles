# Setup fzf
# ---------
if [[ ! "$PATH" == */home/amarantha/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/amarantha/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/amarantha/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/amarantha/.fzf/shell/key-bindings.bash"
