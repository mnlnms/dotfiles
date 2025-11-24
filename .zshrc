if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.json)"
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export EZA_CONFIG_DIR=$HOME/.config/eza/

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
