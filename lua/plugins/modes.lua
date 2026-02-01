return {
  enabled = false,
  "mvllow/modes.nvim",
  tag = "v0.2.1",
  config = function()
    require("modes").setup {
      line_opacity = 0.15,
      -- set_cursor = false,
      -- set_cursorline = false,
      -- set_number = false,
      -- set_signcolumn = false,
    }
    -- vim.o.cmdheight = 0
  end,
}
