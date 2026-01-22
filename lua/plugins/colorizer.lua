return {
  -- "NvChad/nvim-colorizer.lua",
  "norcalli/nvim-colorizer.lua",
  -- event = "BufReadPre",
  -- opts = {
  --   virtualtext = "■",
  --   mode = "virtualtext", -- Set the display mode.
  -- },
  init = function()
    require("colorizer").setup()
  end,
}
