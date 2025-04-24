# VSCodeで直接fishを開いてpathを通すための設定
bass source ~/.profile

. ~/.config/fish/env.fish
. ~/.config/fish/aliases.fish
. ~/.config/fish/keybinds.fish

# bun FIXME .profileに移す
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
