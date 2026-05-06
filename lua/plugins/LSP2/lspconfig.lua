return {
  "neovim/nvim-lspconfig",
  enaled=false,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    servers = {
      lua_ls = {},
      -- omnisharp = {
      --   cmd = { "omnisharp" }, -- or full path: "~/.dotnet/tools/omnisharp"
      --   -- Optional settings
      --   enable_editorconfig_support = true,
      --   organize_imports_on_format = true,
      --   enable_import_completion = true,
      --   sdk_include_prereleases = true,
      -- },
    },
  },
  config = function()
    local signs = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    }

    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename) -- smart rename
    vim.diagnostic.config {
      signs = {
        text = signs, -- Enable signs in the gutter
      },
  end,
}
