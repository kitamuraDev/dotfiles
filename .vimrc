" -------------------------
" 基本設定
" -------------------------
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" -------------------------
" 表示設定
" -------------------------
" コメントの色を水色
hi Comment ctermfg=3
" windowのタイトルを変更
set title
" 行番号
set number
" 現在の行を強調表示
set cursorline
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの補完
set wildmode=list:longest
" コマンドラインの履歴を100件保存
set history=100
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" インデントはスマートインデント
set smartindent
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅
set softtabstop=2
" 対応する括弧を強調表示
set showmatch
" シンタックスハイライト
syntax on

" -------------------------
" 検索
" -------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch

" -------------------------
" key-mapping
" -------------------------
" control + tでNERDTreeを起動
nnoremap <silent><C-t> :NERDTreeToggle<CR>
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" カーソル下の単語を<space*2>ハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" シンプルな行頭・行末・文字検索
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *
" 行頭、行末に移動して挿入モードに切り替え
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a
" ctrl + dで削除
inoremap <C-d> <Del>
noremap <C-d> <Del>

" カーソル行の一つ下の行に空行を挿入
nnoremap <C-j> :<C-u>call append(expand('.'), '')<Cr>j

" emacsライクなカーソル移動(インサートモード時)
" Exコマンドを実装する関数を定義
function! ExecExCommand(cmd)
  silent exec a:cmd
  return ''
endfunction
" 上下移動
inoremap <silent> <expr> <C-p> "<C-r>=ExecExCommand('normal k')<CR>"
inoremap <silent> <expr> <C-n> "<C-r>=ExecExCommand('normal j')<CR>"
" 単語移動
inoremap <silent> <expr> <C-b> pumvisible() ? "<C-e><C-r>=ExecExCommand('normal b')<CR>" : "<C-r>=ExecExCommand('normal b')<CR>"
inoremap <silent> <expr> <C-f> pumvisible() ? "<C-e><C-r>=ExecExCommand('normal w')<CR>" : "<C-r>=ExecExCommand('normal w')<CR>"

" HTMLとXMLの閉じタグ補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END
" 括弧の補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" -------------------------
" プラグインセットアップ 
" -------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

filetype plugin indent on

