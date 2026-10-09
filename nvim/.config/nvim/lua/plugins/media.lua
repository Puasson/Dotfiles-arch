-- media.lua — imagenes en Kitty + colorizer, portado desde nixvim (media.nix).
-- Requiere del sistema: imagemagick, ueberzugpp y el rock `magick` de luarocks.
return {
  {
    "3rd/image.nvim",
    ft = { "markdown", "html", "css" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = { enabled = true },
        html = { enabled = true },
        css = { enabled = true },
      },
      max_width = 100,
      max_height = 12,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      user_default_options = {
        names = true,
        RGB = true,
        RRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        tailwind = true,
      },
    },
  },
}
