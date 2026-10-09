-- theme.lua — catppuccin, portado desde nixvim (theme.nix).
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "auto",
      background = { light = "latte", dark = "mocha" },
      transparent_background = true,
      float = { transparent = true, solid = false },
      term_colors = true,
      integrations = {
        dashboard = true,
        cmp = true,
        blink_cmp = true,
        gitsigns = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotree = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
        lualine = true,
        bufferline = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
