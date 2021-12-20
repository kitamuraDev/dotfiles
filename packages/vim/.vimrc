" -------------------------
" 基本設定
" -------------------------
set encoding=utf-8 " ファイル読み込み時の文字コード
scriptencoding utf-8 " Vim script内でマルチバイト文字を使う場合の設定
set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set autoread " 編集中のファイルが変更されたら自動で読み直す
set hidden " バッファが編集中でもその他のファイルを開けるように
set showcmd " 入力中のコマンドをステータスに表示

" -------------------------
" 表示設定
" -------------------------
set number " 行番号
set relativenumber " 相対行番号
set cursorline " 現在の行を強調表示
set expandtab " Tab文字を半角スペース
set shiftwidth=2 " インデント幅
set softtabstop=2 " タブキー押下時に挿入される文字幅
set showmatch " 対応する括弧を強調表示
syntax on " シンタックスハイライト

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
set incsearch " インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set ignorecase " 検索するときに大文字小文字を区別しない
set smartcase " 小文字で検索すると大文字と小文字を無視して検索
set hlsearch " 検索結果をハイライト表示
set wrapscan " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索

" -------------------------
" key-mapping
" -------------------------
" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" カーソル下の単語を<space*2>ハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" change normal mode
inoremap <silent> jj <Esc>

" Exコマンドを実装する関数を定義
function! ExecExCommand(cmd)
  silent exec a:cmd
  return ''
endfunction
" 単語移動(in insert mode)
inoremap <silent> <expr> <C-b> pumvisible() ? "<C-e><C-r>=ExecExCommand('normal b')<CR>" : "<C-r>=ExecExCommand('normal b')<CR>"
inoremap <silent> <expr> <C-f> pumvisible() ? "<C-e><C-r>=ExecExCommand('normal w')<CR>" : "<C-r>=ExecExCommand('normal w')<CR>"

" ctrl + dで削除
inoremap <C-d> <Del>
noremap <C-d> <Del>

" 行頭、行末に移動して挿入モードに切り替え
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^i

" 行頭・行末・文字検索
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *

" 画面半分先へ。画面半分戻るは[C-u]
noremap <C-m> <C-d>
" カーソル固定で下にスクロール。上にスクロールは[C-y]
noremap <C-i> <C-e>

" カーソル行の一つ上の行に空行を挿入
nnoremap <C-k> O<Esc>
" カーソル行の一つ下の行に空行を挿入
nnoremap <C-j> o<Esc>

" カーソル位置から行末までをycdv
nnoremap yl y$
nnoremap cl c$
nnoremap dl d$
nnoremap vl v$
