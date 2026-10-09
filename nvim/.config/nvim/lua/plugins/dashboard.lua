-- dashboard.lua — doom con arte SUBARU + fortune, portado desde nixvim (dashboard.nix).
local function header()
  local art_file = vim.fn.stdpath("config") .. "/subaru-xvim.txt"
  local ok, lines = pcall(vim.fn.readfile, art_file)
  if ok and lines and #lines > 0 then
    return lines
  end
  return { "SUBARU" }
end

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "doom",
      config = {
        header = header(),
        center = {
          { icon = "  ", icon_hl = "Function", desc = "Find file      ", desc_hl = "Function", key = "f", key_hl = "Number", key_format = " %s", action = "Telescope find_files" },
          { icon = "  ", icon_hl = "Function", desc = "New file       ", desc_hl = "Function", key = "n", key_hl = "Number", key_format = " %s", action = "ene | startinsert" },
          { icon = "  ", icon_hl = "Function", desc = "Recent files   ", desc_hl = "Function", key = "r", key_hl = "Number", key_format = " %s", action = "Telescope oldfiles" },
          { icon = "  ", icon_hl = "Function", desc = "Find text      ", desc_hl = "Function", key = "g", key_hl = "Number", key_format = " %s", action = "Telescope live_grep" },
          { icon = "  ", icon_hl = "Function", desc = "Dotfiles       ", desc_hl = "Function", key = "c", key_hl = "Number", key_format = " %s", action = "e $HOME/Documents/dotfiles" },
          { icon = "  ", icon_hl = "Function", desc = "Restore Session", desc_hl = "Function", key = "s", key_hl = "Number", key_format = " %s", action = "lua require('auto-session').RestoreSession()" },
          { icon = "  ", icon_hl = "Function", desc = "Explorer       ", desc_hl = "Function", key = "e", key_hl = "Number", key_format = " %s", action = "Neotree toggle" },
          { icon = "  ", icon_hl = "Function", desc = "Quit           ", desc_hl = "Function", key = "q", key_hl = "Number", key_format = " %s", action = "qa" },
        },
        footer = function()
          local handle = io.popen("fortune -s 2>/dev/null")
          local fortune = handle and handle:read("*a") or ""
          if handle then handle:close() end
          fortune = fortune:gsub("%s+$", "")
          if fortune == "" then fortune = "Steady throttle, clean lines." end
          local lines = { "", "⚡ SUBARU" }
          for line in fortune:gmatch("[^\n]+") do
            table.insert(lines, "  " .. line)
          end
          return lines
        end,
      },
    },
  },
}
