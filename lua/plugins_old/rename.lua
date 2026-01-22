return {
  enabled = false,
  "filipdutescu/renamer.nvim",
  branch = "master",
  dependecies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<leader>r",
      '<cmd>lua require("renamer").rename()<cr>',
      { noremap = true, silent = true }
    )
  end,
}
