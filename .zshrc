## -------------------------
## Git系
## -------------------------
## << 追加予定 >> - interactiveモード的な感じにしたい。要は対話形式(例：gcmと打てば、「コミットメッセージを入力してください」のようなメッセージが返ってくるような感じ)

alias g='git'
alias gitls='alias | grep git'
## <操作履歴を10個まで表示する>
alias ghis='git reflog --date=local -n 10'
alias gtree='git log --graph'
alias gol='git log --oneline'
alias gs='git status'
alias gb='git branch'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gps='git push origin'
alias gpl='git pull origin'
alias gcl='git clone'
alias gco='git checkout'
alias gco.='git checkout .'
alias gcom='git checkout master'

function gbs() {
    git branch;
    git status;
}


## -------------------------
## npm系
## -------------------------



## -------------------------
## Homebrew系
## -------------------------
## <<追加予定>> - brew info の関数を作る

alias bl='brew list' 
alias bdoc='brew doctor'
alias bconf='brew --config'


## -------------------------
## mysql系
## -------------------------
alias msls='alias | grep mysql'
alias msv='mysql --version'
alias msstart='mysql.server start'
alias msresta='mysql.server restart'
alias msstop='mysql.server stop'
alias msping='mysqladmin ping -u root -p'
alias msrootin='mysql -u root -p'

## -------------------------
## その他 
## -------------------------
## << 追加予定 >> - vzとszを組み合わせた関数を作る
 
alias vi='vim'
alias q='exit'
## <open files and read source alias>
alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vtm='vim ~/.tmux.conf'
alias stm='source ~/.tmux.conf'
alias vv='vim ~/.vimrc'
alias sv='source ~/.vimrc'
alias vgv='vim ~/.gvimrc'
alias sgv='source ~/.gvimrc'
## <tree系> 
alias tr='tree'
alias trdp='tree -Dp'
## <lsよりコマンド打ちやすいllで、色付き隠しファイル込属性区別付きl>s
alias ll='ls -alFG'
## <カレントディレクトリのパスをコピー>
alias pwdc='pwd | tr -d "\n" | pbcopy'
## <.DS_Storeを削除>
alias dsdel='find . -name '.DS_Store' -type f -ls -delete'

## -------------------------
## cd系
## -------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'





