return {
  "apyra/nvim-unity-sync",
  enabled = false,
  config = function()
    require("unity.plugin").setup {
      -- Configs here (Optional)
    }
  end,
  ft = "cs",
}
