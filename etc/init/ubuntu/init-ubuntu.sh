#!/bin/bash -eu

has() {
  type "$1" > /dev/null 2>&1
}
dir_name=$(cd $(dirname $0); pwd)

# brew

if ! has "brew"; then
  # https://brew.sh/
  echo "Install homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

echo "Install homebrew apps"
cd $dir_name
brew bundle

