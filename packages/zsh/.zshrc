# -------------------------
# 基本設定
# -------------------------
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

eval "$(mise activate zsh)"
eval "$(zoxide init zsh --cmd cd)"
source ~/.safe-chain/scripts/init-posix.sh

autoload -Uz compinit && compinit # zshの補完を有効化
setopt auto_list # 補完候補を一覧表示する
setopt auto_menu # tabで順に補完候補を切り替える
setopt auto_cd # パス直打ちでディレクトリ移動

# -------------------------
# git
# -------------------------
alias g='git'
alias gitls='alias | grep git'
alias gco='gitmoji -c'
alias gcd='cd $(ghq root)/$(ghq list | peco)'

# Basic commands
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gsh='git stash'
alias gshls='git stash list'
alias gf='git fetch'
alias gm='git merge'
alias gpush='git push origin HEAD'
alias gpull='git pull --rebase origin main'

# git log
alias oneline='git log --oneline -n10'
alias ggp='git log --graph'
alias ghis='git reflog --date=local -n 10'

# mainブランチ以外を削除
alias del_other_main='git branch | grep -v main | xargs git branch -D'

# ステージング前のファイルをクリアする(clear unstaging)
alias cus='git restore . && git clean -df'

# ローカルとリモートの比較
alias gdmain='git fetch origin main && git diff main origin/main'

# ローカルの作業ブランチをmainブランチにマージ
alias tomain='git switch main && git merge -'

# 新規ブランチを作成してチェックアウト
function gsc() {
  echo "Please enter the new branch" && read branch;
  git switch -c ${branch}
}

# git stash
function gshf() {
  local action selected stash_ref message

  # Gitリポジトリ内で実行しているか確認
  if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    print -u2 "gshf: not a Git repository"
    return 1
  fi

  # 実行するstash操作を選択
  action=$(printf '%s\n' save apply pop show drop diff | fzf --prompt='stash action> ') || return
  [[ -z "$action" ]] && return 0

  # 新しいstashを保存
  if [[ "$action" == save ]]; then
    read -r "message?stash message: " || return
    git stash push -u -m "$message"
    return
  fi

  # 操作対象のstashを選択
  selected=$(git stash list | fzf --prompt='stash> ') || return
  [[ -z "$selected" ]] && return 0
  stash_ref=${selected%%:*}

  # 選択した操作を実行
  case "$action" in
    # stashを適用（stashは残す）
    apply) git stash apply "$stash_ref" ;;
    # stashを適用して削除
    pop) git stash pop "$stash_ref" ;;
    # stashの差分を表示
    show) git stash show --patch "$stash_ref" ;;
    # stashと現在の作業ツリーを比較
    diff) git diff "$stash_ref" ;;
    # 確認後にstashを削除
    drop)
      read -q "confirm?Drop $stash_ref? [y/N] " || { print; return 0; }
      print
      git stash drop "$stash_ref"
      ;;
  esac
}

# -------------------------
# Homebrew
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
alias ls="eza --git"
alias ll='eza -aahl --git'

# .zshrc 閲覧/編集
alias rz='view -M ~/.zshrc'
alias wz='vim ~/.zshrc'

# cd系
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ファイル閲覧系
alias les='less -N'
alias vw='view -M'

# tree系
alias tr='tree'
alias trdp='tree -Dp'

# -------------------------
# fzf
# -------------------------
# セットアップ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ローカルに存在するbranchを選択して切り替える
fst() {
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

# -------------------------
# yazi
# -------------------------
function ya() {
  tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
