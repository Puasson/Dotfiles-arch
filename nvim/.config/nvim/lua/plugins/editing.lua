-- editing.lua — which-key, gitsigns, todo-comments, trouble, comment, autopairs.
-- Portado desde nixvim (plugins.nix).
return {
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "lewis6991/gitsigns.nvim", event = "VeryLazy", opts = {} },
  { "folke/todo-comments.nvim", event = "VeryLazy", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
