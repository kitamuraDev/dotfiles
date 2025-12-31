<br />

<h1 align="center">.dotfiles</h1>

<br />

## セットアップ

1. Homebrew インストール
   - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
   - Homebrew に従いパスを通す
2. git インストール
   - `brew install git`
3. インストールスクリプトを叩く
   - `curl -o - https://raw.githubusercontent.com/kitamuraDev/dotfiles/main/install | sh`
4. VScode を起動 && `~/Library/Application\ Support/Code/User/settings.json`を削除（シンボリックリンクを貼るので）
5. VScode セットアップスクリプトを叩く
   - `sh ~/dotfiles/vscode_setup`
6. .gitignore のシンボリックリンクを貼る
   - `ln -s ~/dotfiles/.gitignore ~`

<br />

## symlink が生きているファイルを事前に削除

```
curl -o - https://raw.githubusercontent.com/kitamuraDev/dotfiles/main/delete-symlink | sh
```
