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

-- highlight long commit headers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		-- Highlight the first line if it exceeds 50 characters
		vim.api.nvim_exec(
			[[
      syntax match longline /^.\{51,}/
      highlight longline ctermbg=red guibg=red
    ]],
			false
		)
	end,
})

-- wrap body text to 72 chars
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.textwidth = 72
	end,
})
