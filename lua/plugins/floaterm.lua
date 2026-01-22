return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  opts = { border = true, size = { h = 75, w = 85 } },
  cmd = "FloatermToggle",
  -- config = function()
  --   require("floaterm").setup()
  --   -- Keymaps
  --   -- vim.keymap.set("n", "<c-/>", "<cmd>FloatermToggle<CR>", { desc = "Toggle Floaterm" })
  -- end,
  keys = {
    { "<c-/>", mode = { "n", "t" }, "<cmd>FloatermToggle<CR>", desc = "Toggle terminal" },
    {
      "<c-a>",
      mode = { "t" },
      function()
        require("floaterm.api").new_term()
      end,
      desc = "Toggle terminal",
    },
    {
      "<Tab>",
      mode = { "t" },
      function()
        require("floaterm.api").cycle_term_bufs "prev"
      end,
      desc = "Toggle terminal",
    },
    --   "<c-/>",
    --   mode = { "n", "t" },
    --   function()
    --     require("floaterm").toggle()
    --   end,
    --   desc = "Toggle terminal",
    -- },
  },

  -- {
  --   "<C-/>",
  --   function()
  --     require("snacks").terminal.toggle()
  --   end,
  --   desc = "Search Keymaps (Snacks Picker)",
  -- },
}
