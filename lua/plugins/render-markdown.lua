return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    typst = { enable = true, list_items = { enable = false } },
    preview = {
      filetypes = { "markdown", "codecompanion", "typst" },
      ignore_buftypes = {},
    },
  },
}
