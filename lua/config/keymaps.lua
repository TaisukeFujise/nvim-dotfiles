vim.keymap.set("n", "<CR><CR>", "<C-w>w", {noremap=true, silent=true})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", {noremap=true, silent=true, desc="Open parent directory"})
vim.opt.timeoutlen=300
vim.keymap.set("i", "jj", "<Esc>", {silent=true})
vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
