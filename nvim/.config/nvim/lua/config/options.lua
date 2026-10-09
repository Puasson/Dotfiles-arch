-- options.lua — portado desde nixvim (options.nix), 1:1.
local o = vim.opt

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true
o.background = "dark"

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

o.undofile = true
o.swapfile = false
o.backup = false

o.splitright = true
o.splitbelow = true
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8

o.updatetime = 250
o.timeoutlen = 300

o.completeopt = "menu,menuone,noselect"
o.pumheight = 10

o.list = true
o.listchars = "tab:» ,trail:·,nbsp:␣"

o.foldlevel = 99
