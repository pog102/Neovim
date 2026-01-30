return {
  enabled = false,
  "akinsho/toggleterm.nvim",
  version = "*",
  -- if vim.fn.has "win32" == 1 then
  --     	local shell = "pwsh.exe",
  -- end
  config = function()
    require("toggleterm").setup {
      size = vim.o.columns * 0.35,
      -- open_mapping = [[<c-\>]],
      shade_filetypes = {},

      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "vertical",
      close_on_exit = true,
      -- shell = vim.o.shell,
    }
  end,
}
