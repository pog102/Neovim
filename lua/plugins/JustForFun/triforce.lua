return {
  "gisketch/triforce.nvim",
  dependencies = { "nvzone/volt" },
  opts = {},
  config = function()
    require("triforce").setup {
      level_progression = {
        tier_1 = { min_level = 1, max_level = 15, xp_per_level = 200 }, -- Super easy early levels
        tier_2 = { min_level = 16, max_level = 30, xp_per_level = 400 },
        tier_3 = { min_level = 31, max_level = math.huge, xp_per_level = 800 },
      },
      -- data_path = vim.fn.stdpath "config" .. "/triforce.json",
    }
  end,
}
