" -------------------------
" 基本設定
" -------------------------
"文字コードをUFT-8に設定(viewコマンドでエラーが出るため一旦コメントアウト)
" set fenc=utf-8
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
" 相対行番号
set relativenumber
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
" シンプルな行頭・行末・文字検索
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

" カーソル位置の単語をyankする
nnoremap vv vawy
" カーソル位置の単語をカットする
nnoremap cc vawc

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

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

