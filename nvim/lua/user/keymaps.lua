-- short aliases for commonly used options and functions
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--
-- NORMAL MODE
--

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Line insertion in normal mode
keymap("n", "<Leader>o", "o<Esc>0\"_D", opts)
keymap("n", "<Leader>O", "O<Esc>0\"_D", opts)

-- Transparency
keymap("n", "<Leader>t", ":TransparentToggle<CR>", opts)

-- File explorer
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)

-- Terminal
keymap("n", "<C-t>", ":ToggleTerm<CR>", opts)
keymap("n", "<C-p>", ":lua term_python_toggle()<CR>", opts)

--
-- VISUAL
--

-- Stay in indent mode
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
