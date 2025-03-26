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

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- yank motion
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d') -- delete motion
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p') -- paste after cursor
vim.keymap.set("n", "<leader>P", '"+P') -- paste before cursor

local handle = io.popen("pyenv which python3 2>/dev/null")
if handle then
	local python_path = handle:read("*a"):gsub("\n", "")
	handle:close()
	if python_path and python_path ~= "" then
		vim.g.python3_host_prog = python_path
	end
end
