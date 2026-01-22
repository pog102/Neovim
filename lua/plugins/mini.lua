return {
  {

    "echasnovski/mini.nvim",
    version = false,
    -- opts = {
    --   mappings = {
    --     add = "sa",
    --     delete = "sd",
    --     find = "sf",
    --     find_left = "sF",
    --     highlight = "sh",
    --     replace = "sr",
    --     update_n_lines = "sn",
    --   },
    -- },

    config = function()
      require("mini.pairs").setup()
      -- require("mini.indentscope").setup { symbol = "│", options = { try_as_border = true }, draw = { delay = 40 } }
      require("mini.surround").setup()
      require("mini.ai").setup()
      -- require("mini.jump2d").setup()
      require("mini.comment").setup {}
      require("mini.files").setup {
        windows = {
          preview = true,
          width_preview = 60,
          width_focus = 30,
        },

        mappings = {
          go_in = "<right>",
          go_out = "<left>",
        },
      }

      vim.keymap.set("n", "<leader>e", "<cmd>:lua MiniFiles.open()<CR>", { desc = "" })
      -- local map_tex = function()
      --   MiniPairs.map_buf(0, "i", "$", { action = "closeopen", pair = "$$" })
      -- end
      --
      -- vim.api.nvim_create_autocmd("FileType", { pattern = "typ", callback = map_tex })
      -- require("mini.files").setup()
    end,
  },
}
