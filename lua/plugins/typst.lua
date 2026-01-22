return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    init = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map("n", "<leader>t", "<Cmd>TypstPreviewToggle<CR>", opts)
    end,
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
