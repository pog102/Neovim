return {
  enabled = true,
  -- enabled = false,
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 30,
  opts = {},
  config = function()
    require("tokyonight").setup {
      -- use the night style
      transparent = true, -- Enable this to disable setting the background color
      -- style = "night",
      style = "storm",
      styles = {
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
        -- comments = { italic = false },
        -- keywords = { italic = false },
        -- sidebars = transparent and "transparent",
        -- floats = transparent and "transparent",
      },
    }
  end,
}
