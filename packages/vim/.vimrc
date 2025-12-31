" -------------------------
" 基本設定
" -------------------------
scriptencoding utf-8   " Vim script内でマルチバイト文字を使う場合の設定
set encoding=utf-8     " ファイル読み込み時の文字コード
set nobackup           " バックアップファイルを作らない
set noswapfile         " スワップファイルを作らない
set autoread           " 編集中のファイルが変更されたら自動で読み直す
set hidden             " バッファが編集中でもその他のファイルを開けるように
set showcmd            " 入力中のコマンドをステータスに表示
set clipboard+=unnamed " yankした内容をクリップボードに入れる

" -------------------------
" 表示設定
" -------------------------
set number         " 行番号
set relativenumber " 相対行番号
set cursorline     " 現在の行を強調表示
set expandtab      " Tab文字を半角スペース
set shiftwidth=2   " インデント幅
set softtabstop=2  " タブキー押下時に挿入される文字幅
set showmatch      " 対応する括弧を強調表示
syntax on          " シンタックスハイライト

" インサートモード時は縦棒カーソル
if has('vim_starting')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

" -------------------------
" 検索
" -------------------------
set incsearch  " インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set ignorecase " 検索するときに大文字小文字を区別しない
set smartcase  " 小文字で検索すると大文字と小文字を無視して検索
set hlsearch   " 検索結果をハイライト表示
set wrapscan   " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索

" -------------------------
" キーマップ
" -------------------------
" leader設定
let mapleader = "\<space>"

" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" インサートモードから抜ける
inoremap <silent> jj <Esc>

" 行選択
nnoremap vn V

" 雑に上下移動
nnoremap J 10j
nnoremap K 10k

" 行頭/行末/単語検索
nnoremap <Leader>h ^
nnoremap <Leader>l $
nnoremap <Leader>/ *

" カーソル位置から行末までをycdv
nnoremap yl y$
nnoremap cl c$
nnoremap dl d$
nnoremap vl v$

" Emacs風キーバインド
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>d$
inoremap <C-h> <BS>
