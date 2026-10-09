-- motion.lua — flash, portado desde nixvim (motion.nix).
-- Keymaps propios en lua/config/keymaps.lua (s/S/r/R).
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = true },
        search = { enabled = true },
      },
    },
  },
}
