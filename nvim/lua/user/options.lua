--
-- Vim options (see :help options) 
--

-- make sure that when vim fails to write a file the original file is not lost
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.swapfile = false
vim.opt.updatetime = 300

-- use system clipboard (unnamedplus on linux)
vim.opt.clipboard = {"unnamed", "unnamedplus"}

-- bigger command line height
vim.opt.cmdheight = 1

-- completion popup
vim.opt.completeopt = { "menuone", "noselect" }

-- utf-8 file encoding
vim.opt.fileencoding = "utf-8"

-- enable mouse support in all modes
vim.opt.mouse = "a"

-- show at most 10 items in popup menus
vim.opt.pumheight = 10

-- only be case sensitive when search pattern contains upper case letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- show in which mode vim currently is
vim.opt.showmode = false

-- automatically indent when appropriate
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Keep all windows the same size when splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- enable all terminal colors in vim and gui font
vim.opt.termguicolors = true
vim.opt.guifont = "monospace:h17"

-- enable short timeout to wait after partial key sequence
vim.opt.timeout = true
vim.opt.timeoutlen = 750

-- write undo history to a file
vim.opt.undofile = true

-- expand tabs as 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- show line numbers and cursor
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 4

-- always show the signcolumn
vim.opt.signcolumn = "yes"

-- wrap lines at sensible characters
vim.opt.wrap = true
vim.opt.linebreak = true

-- avoid cursor on the window borders
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- don't break word objects at hyphen
vim.opt.iskeyword:append "-"                     

