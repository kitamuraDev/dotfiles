local opt = vim.opt

-- 基本
opt.encoding = 'utf-8'          -- ファイル読み込み時の文字コード
opt.backup = false              -- バックアップファイルを作らない
opt.swapfile = false            -- スワップファイルを作らない
opt.autoread = true             -- 編集中のファイルが変更されたら自動で読み直す
opt.hidden = true               -- バッファが編集中でもその他のファイルを開けるように
opt.showcmd = true              -- 入力中のコマンドをステータスに表示
opt.clipboard:append('unnamed') -- yankした内容をクリップボードに入れる

-- 表示
opt.number = true               -- 行番号
opt.relativenumber = true       -- 相対行番号
opt.cursorline = true           -- 現在の行を強調表示
opt.expandtab = true            -- Tab文字を半角スペース
opt.shiftwidth = 2              -- インデント幅
opt.softtabstop = 2             -- タブキー押下時に挿入される文字幅
opt.showmatch = true            -- 対応する括弧を強調表示
vim.cmd('syntax on')            -- シンタックスハイライト

-- 検索
opt.incsearch = true            -- インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
opt.ignorecase = true           -- 検索するときに大文字小文字を区別しない
opt.smartcase = true            -- 小文字で検索すると大文字と小文字を無視して検索
opt.hlsearch = true             -- 検索結果をハイライト表示
opt.wrapscan = true             -- 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
