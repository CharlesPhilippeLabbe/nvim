vim.keymap.set("n", "<space>ee", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("v", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<tab>h", "<C-w><C-h>")
vim.keymap.set("n", "<tab>j", "<C-w><C-j>")
vim.keymap.set("n", "<tab>k", "<C-w><C-k>")
vim.keymap.set("n", "<tab>l", "<C-w><C-l>")

vim.keymap.set("t", "<tab>h", "<C-\\><C-n><C-w><C-h>")
vim.keymap.set("t", "<tab>j", "<C-\\><C-n><C-w><C-j>")
vim.keymap.set("t", "<tab>k", "<C-\\><C-n><C-w><C-k>")
vim.keymap.set("t", "<tab>l", "<C-\\><C-n><C-w><C-l>")

vim.keymap.set("n", "<C-s-Left>", ":vertical resize -10<cr>")
vim.keymap.set("n", "<C-s-Right>", ":vertical resize +10<cr>")
vim.keymap.set("n", "<C-s-Up>", ":resize +5<cr>")
vim.keymap.set("n", "<C-s-Down>", ":resize -5<cr>")


--vim.keymap.set("n", "<Enter>", "o<Esc>k")
vim.keymap.set("i", "<C-J>", "<CR><Esc>k$a")
vim.keymap.set("n", "ZL", "20zl")
vim.keymap.set("n", "ZH", "20zh")
