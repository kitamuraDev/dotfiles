# -------------------------
# 基本設定
# -------------------------
# <zshの補完を有効化>
autoload -Uz compinit && compinit
# <補完候補を一覧表示する>
setopt auto_list
# <tabで順に補完候補を切り替える>
setopt auto_menu



# -------------------------
# Git系
# -------------------------
# << 追加予定 >> - interactiveモード的な感じにしたい。要は対話形式(例：gcmと打てば、「コミットメッセージを入力してください」のようなメッセージが返ってくるような感じ)

alias g='git'
alias gitls='alias | grep git'
# <操作履歴を10個まで表示する>
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


# -------------------------
# npm系
# -------------------------



# -------------------------
# Homebrew系
# -------------------------
# <<追加予定>> - brew info の関数を作る

alias bl='brew list' 
alias bdoc='brew doctor'
alias bconf='brew --config'


# -------------------------
# mysql系
# -------------------------
alias msls='alias | grep mysql'
alias msv='mysql --version'
alias msstart='mysql.server start'
alias msresta='mysql.server restart'
alias msstop='mysql.server stop'
alias msping='mysqladmin ping -u root -p'
alias msrootin='mysql -u root -p'

# -------------------------
# その他
# -------------------------
# << 追加予定 >> - vzとszを組み合わせた関数を作る
 
alias vi='vim'
alias q='exit'
# <open files and read source alias>
alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vtm='vim ~/.tmux.conf'
alias stm='source ~/.tmux.conf'
alias vv='vim ~/.vimrc'
alias sv='source ~/.vimrc'
alias vgv='vim ~/.gvimrc'
alias sgv='source ~/.gvimrc'
# <tree系>
alias tr='tree'
alias trdp='tree -Dp'
# <lsよりコマンド打ちやすいllで、色付き隠しファイル込属性区別付きl>s
alias ll='ls -alFG'
# <カレントディレクトリのパスをコピー>
alias pwdc='pwd | tr -d "\n" | pbcopy'
# <.DS_Storeを削除>
alias dsdel='find . -name '.DS_Store' -type f -ls -delete'

# -------------------------
# cd系
# -------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'


# -------------------------
# fzf系
# -------------------------
# <セットアップ>
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# <ローカルに存在するbranchを選択して切り替える>
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# <git --graphをfzfに突っ込んだ便利なコマンド。中身が複雑なため、理解できていないが有り難く使わして頂く>
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# <findコマンドで下層までをリスト化。標準出力をパイプでfzfに渡し、最後にcdコマンドに結果を渡す>
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# <インタラクティブなgit add diff>
# <usage: control + d で diff | Enter で add>
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}



# -------------------------
#
# -------------------------




