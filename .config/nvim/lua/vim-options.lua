local o = vim.opt
local g = vim.g

vim.cmd([[colorscheme ]])

-- Global
o.backup = false
o.backupcopy = 'yes'
o.clipboard = 'unnamedplus'
o.completeopt = { 'menu', 'menuone', 'noselect' }
o.encoding = 'UTF-8'
o.errorbells = false
o.fillchars = { vert = ' ' }
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.joinspaces = false
g.mapleader = ' '
o.mouse = 'v'
o.scrolloff = 10
o.shortmess:append({ c = true, S = true })
o.showcmd = true
o.showmatch = true
o.showmode = false
o.showtabline = 1
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.undolevels = 1000
o.wrapscan = true
o.writebackup = false
o.signcolumn = 'yes'
o.wrap = false

-- Buffer
o.expandtab = true
o.fileformat = 'unix'
o.shiftwidth = 2
o.softtabstop = 2
o.spelllang = 'en_us'
o.swapfile = false
o.tabstop = 2
o.undofile = false

-- Window
o.colorcolumn = '+1'
o.cursorline = true
o.list = true
o.number = true
o.relativenumber = true
o.ruler = true
o.laststatus = 3

g.skip_ts_context_commentstring_module = true
