return {
  {
    enabled = false,
    dir = "~/hellwal.nvim/",
    -- dir = "~/tokyonight.nvim/",
    lazy = false,
    priority = 1000,
    -- opts = {
    --   transparency = true,
    -- },
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
