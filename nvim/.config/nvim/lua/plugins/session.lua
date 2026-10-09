-- session.lua — auto-session, portado desde nixvim (session.nix).
return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_save = true,
      auto_restore = false,
      auto_create = true,
      suppressed_dirs = { "~/", "~/Downloads", "/tmp" },
    },
  },
}
