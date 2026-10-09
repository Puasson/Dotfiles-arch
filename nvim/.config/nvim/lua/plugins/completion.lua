-- completion.lua — blink.cmp + snippets + snacks, portado desde nixvim (completion.nix).
return {
  { "L3MON4D3/LuaSnip", version = "v2.*", dependencies = { "rafamadriz/friendly-snippets" } },
  { "rafamadriz/friendly-snippets" },

  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = { preset = "enter" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      signature = { enabled = true },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true },
      words = { enabled = true },
    },
  },

  -- Integracion AI via opencode (opcional; requiere `opencode` en PATH).
  { "sudo-tee/opencode.nvim", dependencies = { "folke/snacks.nvim" }, opts = {} },
}
