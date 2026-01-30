return {
  enable = false,
  "stevearc/overseer.nvim",
  config = function()
    require("overseer").setup {
      output = {
        -- Use a terminal buffer to display output. If false, a normal buffer is used
        use_terminal = true,
        -- If true, don't clear the buffer when a task restarts
        preserve_output = false,
      },
      task_list = {
        direction = "right", -- or "left"
        keymaps = {
          ["q"] = { "<CMD>close<CR>", desc = "Close task list" },
        },
      },
    }
  end,
}
