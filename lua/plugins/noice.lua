return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "rcarriga/nvim-notify",
      -- "MunifTanjim/nui.nvim",
    },
    config = function()
      local noice = require "noice"

      require("notify").setup {
        background_colour = "#000000",
      }
      noice.setup {
        -- popupmenu = {
        --   ---@type 'nui'|'cmp'
        --   backend = "cmp", -- backend to use to show regular cmdline completions
        --   -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        --   -- kind_icons = {}, -- set to `false` to disable icons
        -- },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          -- format = {
          -- 	-- cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
          -- 	--                   help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰮦 :" },
          -- 	--                   search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
          -- 	--                   search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
          -- 	-- filter = { pattern = "^:%s*!", icon = " $ :", lang = "bash" },
          -- 	-- lua = {
          -- 	-- 	pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
          -- 	-- 	icon = "  :",
          -- 	-- 	lang = "lua",
          -- 	-- },
          -- 	-- input = { view = "cmdline_input", icon = " 󰥻 :" }, -- Used by input()
          -- },
        },
        views = {
          popupmenu = {
            -- relative = "editor",
            -- position = {
            --     row = 8,
            --     col = "50%",
            -- },
            -- win_options = {
            --     winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            -- },
          },
          -- mini = {
          --     size = {
          --         width = "auto",
          --         height = "auto",
          --         max_height = 15,
          --     },
          --     position = {
          --         row = -2,
          --         col = "100%",
          --     },
          -- }
        },
        lsp = {
          progress = {
            enabled = true,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
          -- signature = {
          --     auto_open = { enabled = false }, -- disable auto signature help on insert mode
          -- },
          --
        },
        presets = {
          -- bottom_search = true, -- use a classic bottom cmdline for search
          -- command_palette = true, -- position the cmdline and popupmenu together
          -- long_message_to_split = true, -- long messages will be sent to a split
          -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
          -- lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        -- routes = {
        --   {
        --     -- filter = {
        --     --   event = "msg_show",
        --     --   any = {
        --     --     { find = "%d+L, %d+B" },
        --     --     { find = "; after #%d+" },
        --     --     { find = "; before #%d+" },
        --     --     { find = "%d fewer lines" },
        --     --     { find = "%d more lines" },
        --     --   },
        --     -- },
        --     opts = { skip = true },
        --   },
        -- },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          view = "notify", -- default view for messages
          view_error = "notify", -- view for errors
          view_warn = "notify", -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        notify = {
          -- Noice can be used as `vim.notify` so you can route any notification like other messages
          -- Notification messages have their level and other properties set.
          -- event is always "notify" and kind can be any log level as a string
          -- The default routes will forward notifications to nvim-notify
          -- Benefit of using Noice for this is the routing and consistent history view
          enabled = true,
          view = "notify",
        },
        health = {
          checker = true,
        },
        signature = {
          -- enabled = true,
          enabled = false,
        },
      }
    end,
  },
}
