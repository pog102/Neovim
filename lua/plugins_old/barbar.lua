return {
  enabled = false,
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<Tab>", "<Cmd>BufferPrevious<CR>", opts)
    -- map("n", "<A-Right>", "<Cmd>BufferNext<CR>", opts)
    map("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)
  end,
  opts = {
    auto_hide = true,
    icons = {
      separator_at_end = false,
    },
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
