if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.json)"
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

