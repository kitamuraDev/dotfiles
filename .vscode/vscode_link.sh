#!/bin/zsh
ln -s ~/dotfiles/.vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/dotfiles/.vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json 

# install extention
cat extensions | while read line
do
 code --install-extension $line
done

code --list-extensions > extensions
