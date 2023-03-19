# -------------------------
# 基本設定
# -------------------------
export PATH="/usr/local/sbin:$PATH"
# starship
eval "$(starship init zsh)"
# zshの補完を有効化
autoload -Uz compinit && compinit
# 補完候補を一覧表示する
setopt auto_list
# tabで順に補完候補を切り替える
setopt auto_menu
# パス直打ちでディレクトリ移動
setopt auto_cd

# -------------------------
# git
# -------------------------
alias g='git'
alias gitls='alias | grep git'
alias gmj='gitmoji'
alias gc='gitmoji -c'

# Basic commands
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gs='git status'
alias gss='git status -s'
alias gd='git diff'
alias gdc='git diff --cached'
alias gsh='git stash'
alias gshls='git stash list'
alias gf='git fetch'
alias gm='git merge'
alias gst='git switch'
alias gpush='git push origin HEAD'
alias gpull='git pull --rebase origin main'

# git log
alias oneline='git log --oneline -n10'
alias ggp='git log --graph'
alias ghis='git reflog --date=local -n 10'

# mainブランチ以外を削除
alias del_other_main='git branch | grep -v main | xargs git branch -D'

# 「ブランチ」「ステータス」「差分」の確認
alias gbsd='git branch && git status && git diff'

# ステージング前のファイルの状態を取り消す(clear unstaging)
alias cus='git restore .'

# ローカルとリモートの比較
alias gdmain='git fetch origin main && git diff main origin/main'

# ローカルの作業ブランチをmainブランチにマージ
alias tomain='git switch main && git merge -'

# ステージングを取り消す
function restore() {
  git status
  echo "Please enter the file name to be removed from the stage" && read file;
  git restore --staged ${file}
}

# 新規ブランチを作成してチェックアウト
function gsc() {
  echo "Please enter the new branch" && read branch;
  git switch -c ${branch}
}

# -------------------------
# Homebrew系
# -------------------------
alias bl='brew list'
alias bdoc='brew doctor'
alias bconf='brew --config'

# -------------------------
# その他
# -------------------------
alias q='exit'
alias v='vim'
alias vi='vim'
alias cat="bat"
alias ls="exa"

# cd系
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ファイル閲覧系
alias les='less -N'
alias vw='view -M'
alias showz='view -M ~/.zshrc'

# tree系
alias tr='tree'
alias trdp='tree -Dp'

# exa(ls as exa): a(全表示) / l(一列にして表示。権限や所有者などの詳細情報も表示)
alias ll='ls -al'

# -------------------------
# fzf
# -------------------------
# セットアップ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ローカルに存在するbranchを選択して切り替える
fcb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
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

# カレントディレクトリ配下のディレクトリを曖昧検索して移動
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
