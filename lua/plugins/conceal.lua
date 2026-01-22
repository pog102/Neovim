return {
  -- enabled = false,
  "pxwg/math-conceal.nvim",
  event = "VeryLazy",
  build = "make lua51",
  main = "math-conceal",
  opts = {
    enabled = true,
    conceal = {
      "greek",
      "script",
      "math",
      "font",
      "delim",
      "phy",
    },
    ft = { "*.typ" },
  },
}
