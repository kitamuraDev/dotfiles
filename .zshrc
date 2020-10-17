# -------------------------
# 基本設定
# -------------------------
# zshの補完を有効化
autoload -Uz compinit && compinit

# 補完候補を一覧表示する
setopt auto_list

# tabで順に補完候補を切り替える
setopt auto_menu

# パス直打ちでディレクトリ移動
setopt auto_cd

# -------------------------
# Git系
# -------------------------
alias g='git'
alias gitls='alias | grep git'

# 操作履歴を10個まで表示する
alias ghis='git reflog --date=local -n 10'

# Basic commands
alias gtree='git log --graph'
alias ghisall='git log --oneline'
alias gol='git log --pretty=oneline -n 20 --graph --abbrev-commit'
alias gb='git branch'
alias gs='git status'
alias gss='git status -s'
alias gd='git diff'
alias gbsd='git branch && git status && git diff'
alias gpush='git push origin HEAD'
alias gpull='git pull origin'
alias gout='git checkout'
alias gcd='git checkout develop'
alias gf='git fetch'
alias gm='git merge'

# <add, commitの取り消し>
# usage : addをする前。変更した内容すべてを戻す
alias gco.='git checkout .'
# usage : addをした後。ステージングから降りる
function restorefile() {
  echo "Please enter the file name to be removed from the stage" && read restoreFile;
  git restore --staged ${restoreFile}
}
# usage : commitを取り消す。ファイルの内容は残る
alias grs='git reset --soft HEAD^'

# add ~ push
function gacp() {
  git branch && git status;
  echo "Which file to add ??" && read addFile;
  git add ${addFile}
  echo "Please enter the commit comment" && read comment;
  git commit -m ${comment} && git push origin HEAD
}
# add ~ commit
function gac() {
  git branch && git status;
  echo "Which file to add ??" && read addFile;
  git add ${addFile}
  echo "Please enter the commit comment" && read comment;
  git commit -m ${comment} && git status;
}

# 新規ブランチを作成してチェックアウト
function gcb() {
  echo "Please enter the new branch" && read branchName;
  git checkout -b ${branchName}
}

# clone
function clone() {
  echo "Please enter the URL" && read url;
  git clone ${url}
}

# -------------------------
# npm系
# -------------------------
alias nv='npm --version'
alias nini='npm init'
alias ns='npm start'
alias ninst='npm install'
alias ninstg='npm install -g'
alias nls='npm ls'

# -------------------------
# Homebrew系
# -------------------------
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
alias v='vim'
alias vi='vim'
alias q='exit'

# open files and read source alias
function vsz() {
  vim ~/.zshrc && source ~/.zshrc;
}
alias vtm='vim ~/.tmux.conf'
alias vv='vim ~/.vimrc'
alias vgv='vim ~/.gvimrc'

# tmux系
alias tm='tmux'

# tree系
alias tr='tree'
alias trdp='tree -Dp'
# 色付き隠しファイル込属性区別付きls
alias ll='ls -alFG'

# カレントディレクトリのパスをコピー
alias pwdc='pwd | tr -d "\n" | pbcopy'

# .DS_Storeを削除
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
# セットアップ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ローカルに存在するbranchを選択して切り替える
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# git --graphをfzfに食わせた便利なコマンド。中身が複雑なため、理解できていないが有り難く使わして頂く
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

# findコマンドで下層までをリスト化。標準出力をパイプでfzfに渡し、最後にcdコマンドに結果を渡す
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# インタラクティブなgit add diff
# usage: control + d で diff | Enter で add
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

