return {
  "neovim/nvim-lspconfig",
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

    -- local opts = { buffer = ev.buf, silent = true }
    -- opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename) -- smart rename
    vim.diagnostic.config {
      signs = {
        text = signs, -- Enable signs in the gutter
      },
      -- virtual_text = true, -- Specify Enable virtual text for diagnostics
      -- underline = true, -- Specify Underline diagnostics
      -- update_in_insert = false, -- Keep diagnostics active in insert mode
    }

    -- Set the diagnostic config with all icons
    -- vim.lsp.enable "qmlls"
    -- vim.lsp.config "qmllss"
    -- vim.lsp.enable "lua_ls"
    -- vim.lsp.enable "pyright"
    -- vim.lsp.enable "tinymist"
    -- vim.lsp.enable "hyprls"

    -- vim.lsp.enable "ruby_ls"
    -- vim.lsp.enable "gdtoolkit"
    --   -- Setup servers
    --   -- local cmp_nvim_lsp = require "cmp_nvim_lsp"
    --   -- local capabilities = cmp_nvim_lsp.default_capabilities()

    -- vim.lsp.enable "omnisharp"
    -- vim.lsp.config("omnisharp", {
    --   cmd = { "omnisharp" }, -- or full path: "~/.dotnet/tools/omnisharp"
    --   -- Optional settings
    --   enable_editorconfig_support = true,
    --   organize_imports_on_format = true,
    --   enable_import_completion = true,
    --   sdk_include_prereleases = true,
    -- })
  end,
}
