# dotfiles-ubuntu

## Installation

```sh
cd ~
git clone https://github.com/hushin/dotfiles-ubuntu.git .dotfiles
```

## Initialize

```sh
cd .dotfiles
make deploy
make init
```


```sh
bash -c 'cat <<EOF > $HOME/.gitconfig.local
[user]
  name = hushin
  email = nnnnot+github@gmail.com
EOF
'
```

## TODO

* [ ] pbcopy
* [ ] browser
