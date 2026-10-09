-- init.lua — dotfiles (Arch puro, lazy.nvim). Portado desde nixvim (default.nix).
-- Sin dependencias Nix: los binarios externos van por pacman/chaotic-aur y Mason.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard como en nixvim: unnamedplus (en Arch Wayland lo sirve wl-clipboard).
vim.opt.clipboard = "unnamedplus"

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
