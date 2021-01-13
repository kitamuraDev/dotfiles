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
alias oneline='git log --oneline -n15'
alias ga='git add'
alias gb='git branch'
alias gs='git status'
alias gss='git status -s'
alias gd='git diff'
alias gbsd='git branch && git status && git diff'
alias mwpush='git push origin HEAD && git checkout main && git merge - && git push origin HEAD'
alias gpush='git push origin HEAD'
alias gpull='git pull origin'
alias gout='git checkout'
alias gf='git fetch'
alias gm='git merge'

# <add, commitの取り消し>
# usage : addをする前。変更した内容すべてを戻す
alias gout.='git checkout .'
# usage : addをした後。ステージングから降りる
function restorefile() {
  git status
  echo "Please enter the file name to be removed from the stage" && read restoreFile;
  git restore --staged ${restoreFile}
}
# usage : コミットだけ取り消したい
alias grs='git reset --soft HEAD^'
# usage : コミットを取り消して、変更内容も取り消したい
alias grh='git reset --hard HEAD^'

# git commit -m
function gcm() {
  git branch && git status;
  echo "Please prefix" && read prefix && echo "Please comment" && read comment;
  git commit -m "<${prefix}>: ${comment}" && git status;
}
# add ~ commit
function gac() {
  git branch && git status;
  echo "Please select file" && read file;
  git add ${file}
  echo "Please prefix" && read prefix && echo "Please comment" && read comment;
  git commit -m "<${prefix}>: ${comment}" && git status;
}
# add ~ push
function gacp() {
  git branch && git status;
  echo "Please select file" && read file;
  git add ${file}
  echo "Please prefix" && read prefix && echo "Please comment" && read comment;
  git commit -m "<${prefix}>: ${comment}" && git push origin HEAD
}

# 新規ブランチを作成してチェックアウト
function gcb() {
  echo "Please enter the new branch" && read branch;
  git checkout -b ${branch}
}

# clone
function clone() {
  echo "Please enter the URL" && read url;
  git clone ${url}
}


# ブランチ名を色付きで表示させる関数
function rprompt-git-current-branch {
  local branch_name st branch_status
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# -------------------------
# npm系
# -------------------------
alias npmls='alias | grep npm'
alias nv='npm --version'
alias nini='npm init'
alias nrb='npm run build'
alias ns='npm start'
alias ninst='npm install'
alias ninstg='npm install -g'
alias nls='npm ls'

# -------------------------
# Firebase系
# -------------------------
alias fl="firebase login"
alias finit="firebase init"
alias fd="firebase deploy"

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
alias vv='vim ~/.vimrc'
alias vgv='vim ~/.gvimrc'
alias vtm='vim ~/.tmux.conf'

# ファイル閲覧系
alias les='less -N'
alias vw='view -M'
alias vwz='view -M ~/.zshrc'

# tmux系
alias tm='tmux'

# tree系
alias tr='tree'
alias trdp='tree -Dp'
# 色付き隠しファイル込属性区別付きls
alias ll='ls -alFG'

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



