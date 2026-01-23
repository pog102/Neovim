return {
  "olimorris/codecompanion.nvim",
  -- enabled = false,
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "github/copilot.vim",
  },
  config = function()
    require("codecompanion").setup {
      ignore_warnings = true,
      display = {
        chat = {
          window = {
            position = "right",
            width = 0.35,
          },
        },
      },
      strategies = {
        chat = {
          -- adapter = "gemini",
          adapter = "copilot",
        },
        inline = {
          -- adapter = "gemini",
          adapter = "copilot",
        },
      },
    }
    -- vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
    -- Remap Copilot accept mapping from Tab to Caps Lock
    -- vim.api.nvim_set_keymap("n", "<CapsLock>", "<Plug>(copilot-accept)", { noremap = false, silent = true })
  end,
}
