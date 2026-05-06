return {{
  'mason-org/mason.nvim',
  opts = {},
},
{
  'neovim/nvim-lspconfig',
},
{
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {
        automatic_enable = true,
  },
},
{
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  opts = {
    ensure_installed = {
      'lua_ls',
      'stylua',
      'prettier',
    },
  },
},
}
