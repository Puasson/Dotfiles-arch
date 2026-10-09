-- autocmds.lua — sync de tema con el sistema (theme-apply) + highlights del dashboard.
-- Portado desde nixvim (theme.nix / dashboard.nix extraConfigLua).
local function apply_system_theme()
  local bg_file = vim.fn.expand("~/.cache/quickshell/theme/nvim-background")
  local f = io.open(bg_file, "r")
  if f then
    local bg = f:read("*l") or ""
    f:close()
    bg = bg:gsub("%s+", "")
    if bg == "light" or bg == "dark" then
      vim.o.background = bg
    end
  end
end

apply_system_theme()

-- theme-apply avisa con SIGUSR1 (pkill -USR1 -x nvim) tras escribir el modo.
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    apply_system_theme()
    vim.cmd("colorscheme catppuccin")
  end,
})

-- Header azul + footer cian del dashboard, re-aplicados tras cada colorscheme.
local dash_hl = vim.api.nvim_create_augroup("SubaruDashboardHl", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = dash_hl,
  callback = function()
    vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Function" })
    vim.api.nvim_set_hl(0, "DashboardFooter", { link = "DiagnosticHint" })
  end,
})
vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Function" })
vim.api.nvim_set_hl(0, "DashboardFooter", { link = "DiagnosticHint" })
