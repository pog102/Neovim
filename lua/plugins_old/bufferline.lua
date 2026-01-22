return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>") -- show definition, references
    vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>") -- show definition, references
    vim.keymap.set("n", "<S-left>", "<C-w>h") -- show definition, references
    vim.keymap.set("n", "<S-Right>", "<C-w>l") -- show definition, references
    -- vim.keymap.set("n", "<Alt>left", "<cmd>bdelete<CR>") -- show definition, references
    require("bufferline").setup {

      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead}

        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        -- auto_toggle_bufferline = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match "error" and " " or " "
          return " " .. icon .. count
        end,
      },
    }
  end,
}
