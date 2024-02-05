vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({"n", "v"}, "<leader>y", "+y")
vim.keymap.set({"n", "v", "i"}, "§", "<Esc>")

vim.keymap.set({"n"}, "<leader>n", ":bnext<cr>")
vim.keymap.set({"n"}, "<leader>b", ":bprev<cr>")

vim.keymap.set({"n"}, "<leader>g", ":Git ")

vim.keymap.set({"n"}, "<leader>w", "<C-w>w")
vim.keymap.set({"n"}, "<leader>vs", ":vsplit<cr>")
