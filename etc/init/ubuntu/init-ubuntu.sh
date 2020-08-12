#!/bin/bash -eu

has() {
  type "$1" > /dev/null 2>&1
}
dir_name=$(cd $(dirname $0); pwd)

# apt
sudo apt-get install -y build-essential curl file git

# brew
if ! has "brew"; then
  # https://brew.sh/
  echo "Install homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
brew update

echo "Install homebrew apps"
cd $dir_name
brew bundle

source ~/.profile

# diff-highlight
[ -h /usr/local/bin/diff-highlight ] || sudo ln -s $(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

# asdf
[ -e ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
. $HOME/.asdf/asdf.sh

# node
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
[ -e ~/.gnupg/crls.d ] || bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

asdf plugin update --all

# .tool-versions
asdf install

# tmux
[ -e ~/.tmux-powerline ] || git clone https://github.com/erikw/tmux-powerline.git ~/.tmux-powerline

# gem
gem install git-browse-remote

# emacs
brew install emacs
[ -e ~/.emacs.d ] || git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d
git fetch --prune
git checkout --force develop
git reset --hard origin/develop

# fish
fish $dir_name/init-fish.fish