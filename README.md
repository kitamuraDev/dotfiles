# .dotfiles

## インストールスクリプト

```
curl -o - https://raw.githubusercontent.com/kitamuraDev/dotfiles/main/install | sh
```

## symlink が生きているファイルを事前に削除

```
curl -o - https://raw.githubusercontent.com/kitamuraDev/dotfiles/main/delete-symlink | sh
```

## .gitignore を手動で symlink を貼る

※ .gitignore に関しては手動で symlink を貼る（stow でリンクできないか模索中。package/gitignore でディレクトリを作ればいけるかも）

```
ln -s ~/dotfiles/.gitignore ~
```

<br />

## ファイル構成

```
.
├── Brewfile
├── README.md
├── delete-symlink
├── extensions
├── install
└── packages
    ├── git
    ├── starship
    ├── vim
    ├── vscode
    │   ├── keybindings.json
    │   └── settings.json
    └── zsh
```

<br />

## 環境

- OS : macOS Catalina 10.15.7
- Shell : Zsh
