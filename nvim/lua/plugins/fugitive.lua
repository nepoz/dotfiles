return {
  "tpope/vim-fugitive",
  event = "BufWinEnter",
  keys = {
    {"<leader>gs", "<cmd> Git <cr>", desc = "Open Fugitive"},
  },
}
