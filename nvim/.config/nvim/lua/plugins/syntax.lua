-- syntax.lua — treesitter + contexto + autotag + rainbow, portado desde nixvim (syntax.nix).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python", "javascript", "typescript", "tsx", "nix", "lua", "qmljs",
        "html", "css", "json", "yaml", "markdown", "markdown_inline", "bash",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },
  { "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
  { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
}
