-- [[ Configure and install plugins ]]
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- plugins/ディレクトリ内の全ファイルを自動読み込み
  },
  checker = { enabled = true },
})
