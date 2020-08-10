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

