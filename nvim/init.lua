vim.g.mapleader = " "

require("config.lazy")
require("config.lsp")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.fillchars = "eob: "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.colorcolumn = "80"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2e3440", underline = false })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2e3440" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
