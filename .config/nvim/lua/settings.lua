local o = vim.o
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

-- general
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.signcolumn = 'auto'
o.confirm = true
o.completeopt = 'menuone,noselect'
o.ignorecase = true
o.smartcase = true
o.scrolloff = 7
o.foldcolumn = 'auto'
o.wrap = true
o.breakindent = true
o.updatetime = 100
o.timeoutlen = 500
o.showmode = false
o.showmatch = true

o.colorcolumn = '+1'
o.cmdheight = 1
o.shortmess = 'atOS'
o.whichwrap = '<,>,h,l'
o.termguicolors = true
o.showtabline = 1
o.helpheight = 20

-- tabs and indent
o.tabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.autoindent = true
o.smartindent = true

-- backup settings
o.backup = false
o.swapfile = false
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- better buffer splitting
o.splitright = true
o.splitbelow = true

o.textwidth = 120

o.hlsearch = true
o.incsearch = true

-- NETRW
vim.g.netrw_banner = 0
vim.g.netrw_browse_spit = 2
vim.g.netrw_liststyle = 3
