return {
  "apyra/nvim-unity-sync",
  enable = true,
  config = function()
    require("unity.plugin").setup {
      -- Configs here (Optional)
    }
  end,
  ft = "cs",
}
