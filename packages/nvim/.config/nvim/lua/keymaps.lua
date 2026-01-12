local keymap = vim.keymap

-- -------------------------
-- BASE
-- -------------------------
-- leader設定
vim.g.mapleader = " "

-- ESC連打でハイライト解除
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { silent = true })

-- インサートモードから抜ける
keymap.set('i', 'jj', '<Esc>', { silent = true })

-- 行選択
keymap.set('n', 'vn', 'V')

-- 雑に上下移動
keymap.set('n', 'J', '10j')
keymap.set('n', 'K', '10k')

-- 行頭/行末/単語検索
keymap.set('n', '<Leader>h', '^')
keymap.set('n', '<Leader>l', '$')
keymap.set('n', '<Leader>/', '*')

-- カーソル位置から行末までをycdv
keymap.set('n', 'yl', 'y$')
keymap.set('n', 'cl', 'c$')
keymap.set('n', 'dl', 'd$')
keymap.set('n', 'vl', 'v$')

-- Emacs風キーバインド
keymap.set('i', '<C-b>', '<Left>')      -- ←
keymap.set('i', '<C-f>', '<Right>')     -- →
keymap.set('i', '<C-a>', '<C-o>^')      -- 行頭へ
keymap.set('i', '<C-e>', '<End>')       -- 行末へ
keymap.set('i', '<C-d>', '<Del>')       -- Del
keymap.set('i', '<C-k>', '<C-o>d$')     -- 行末まで削除
keymap.set({'i', 'c'}, '<C-h>', '<BS>') -- BackSpace

-- -------------------------
-- VScode
-- -------------------------
if vim.g.vscode then
  local vscode = require('vscode')

  keymap.set('n', '<Leader>p', function() vscode.call('workbench.action.showCommands') end)   -- コマンドパレット
  keymap.set('n', '<Leader>q', function() vscode.call('workbench.action.quickOpen') end)      -- クイックオープン
  keymap.set('n', '<Leader>f', function() vscode.call('workbench.action.showAllEditors') end) -- 現在開いているファイルを検索
  keymap.set('n', '<Leader>e', function() vscode.call('workbench.view.explorer') end)         -- エクスプローラーにフォーカスを移動
  keymap.set('n', '<Leader>a', function() vscode.call('workbench.action.findInFiles') end)    -- 全検索
  keymap.set('n', '<Leader>r', function() vscode.call('editor.action.rename') end)            -- リネーム
  keymap.set('n', '<Leader>d', function() vscode.call('editor.action.peekDefinition') end)    -- 定義を表示
  keymap.set('n', '<Leader>z', function() vscode.call('workbench.action.toggleZenMode') end)  -- 禅モード切替
  keymap.set('n', '<C-h>', function() vscode.call('workbench.action.previousEditor') end)     -- タブ移動（左）
  keymap.set('n', '<C-l>', function() vscode.call('workbench.action.nextEditor') end)         -- タブ移動（右）
end
