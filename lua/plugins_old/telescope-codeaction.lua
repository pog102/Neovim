return {
  "rachartier/tiny-code-action.nvim",
  enabled = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },

    -- optional picker via telescope
    { "nvim-telescope/telescope.nvim" },
  },
  event = "LspAttach",
  opts = { picker = "buffer" },
  config = function()
    vim.keymap.set({ "n", "x" }, "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { noremap = true, silent = true })
  end,
}
