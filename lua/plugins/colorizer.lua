return {
  -- "NvChad/nvim-colorizer.lua",
  "norcalli/nvim-colorizer.lua",
  enabled=false,
  -- event = "BufReadPre",
  -- opts = {
  --   virtualtext = "■",
  --   mode = "virtualtext", -- Set the display mode.
  -- },
  init = function()
    require("colorizer").setup()
  end,
}
