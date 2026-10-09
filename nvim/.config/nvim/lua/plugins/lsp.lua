-- lsp.lua — 12 servidores, portado desde nixvim (lsp.nix).
-- Los binarios los instala Mason (:Mason) o pacman/chaotic-aur del sistema.
local servers = {
  "pyright",
  "ruff",
  "ts_ls",
  "eslint",
  "nil_ls",
  "qmlls",
  "html",
  "cssls",
  "tailwindcss",
  "emmet_ls",
  "jsonls",
}

return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- Mason no empaqueta todos (p.ej. qmlls/nil_ls pueden faltar segun plataforma);
      -- los ausentes se sirven del PATH del sistema sin romper el setup.
      ensure_installed = { "pyright", "ruff", "ts_ls", "eslint", "lua_ls", "html", "cssls", "tailwindcss", "emmet_ls", "jsonls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local caps = require("blink.cmp").get_lsp_capabilities()

      for _, name in ipairs(servers) do
        lspconfig[name].setup({ capabilities = caps })
      end
      lspconfig.lua_ls.setup({
        capabilities = caps,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
  },
}
