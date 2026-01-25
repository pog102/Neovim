return {

  -- {
  --   "aznhe21/actions-preview.nvim",
  --   enabled = true,
  --   event = "LspAttach",
  --   opts = {},
  --   config = function()
  --     require("actions-preview").setup {
  --       diff = {
  --         ctxlen = 3,
  --       },
  --
  --       backend = { "snacks" },
  --       snacks = {
  --         layout = { preview = false, preset = "dropdown" },
  --         -- layout = {
  --         --   sorting_strategy = "ascending",
  --         --   layout_strategy = "vertical",
  --         --   layout_config = {
  --         --     width = 0.8,
  --         --     height = 0.9,
  --         --     prompt_position = "top",
  --         --     preview_cutoff = 20,
  --         --     preview_height = function(_, _, max_lines)
  --         --       return max_lines - 15
  --         --     end,
  --         --   },
  --         -- },
  --       },
  --     }
  --     vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
  --   end,
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        input = {
          keys = {
            n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
          },
        },
      },
      -- Snacks Modules
      input = {
        enabled = true,
        provider = "snacks",
        provider_opts = {
          -- Additional snacks.input options
          title = "Avante Input",
          icon = " ",
        },
      },
      quickfile = {
        enabled = true,
        -- exclude = { "typst" },
      },
      rename = { enabled = true },

      picker = {
        enabled = true,
        --   notifications = {
        --     enabled = true,
        --   },
        sources = {
          -- yank = { Action = { notify = false } },
          -- actions = { yank = { notify = false } },
          notifications = {
            enabled = true,
            confirm = { "yank", "close" },
          },
        },
      },
      image = {
        enabled = false,
        doc = {
          float = true, -- show image on cursor hover
          inline = false, -- show image inline
          max_width = 50,
          max_height = 30,
          wo = {
            wrap = false,
          },
        },
        convert = {
          notify = true,
          command = "magick",
        },
        -- img_dirs = {
        --   "img",
        --   "images",
        --   "assets",
        --   "static",
        --   "public",
        --   "media",
        --   "attachments",
        --   "Archives/All-Vault-Images/",
        --   "~/Library",
        --   "~/Downloads",
        -- },
      },
      terminal = {
        enabled = false,
      },
      -- win = {
      --   enabled = true,
      --   wo = {
      --     spell = false,
      --     wrap = false,
      --     signcolumn = "yes",
      --     statuscolumn = " ",
      --     conceallevel = 3,
      --   },
      -- },
      -- statuscolumn={enabled=true},
      indent = { enabled = true, only_scope = true },
      notifier = {
        enabled = true,
        exclude = { "Yanked to register" },
        -- filter = function(notif)
        --   -- hide yank notifications
        --   if notif.msg:match "Yanked to register" then
        --     return false
        --   end
        --   return true
        -- end,
        -- confirm = { "copy", "close" },
      },
      dashboard = {
        enabled = true,
        preset = {
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession search" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
        ]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", limit = 3, indent = 2, padding = 1 },
          -- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          -- {
          --   icon = " ",
          --   title = "Restore Session",
          --   section = "session",
          --   action = ":AutoSession restore",
          --   indent = 2,
          --   padding = 1,
          -- },
          { section = "startup" },
        },
      },
    },
    keys = {
      {
        "gr",
        function()
          require("snacks").picker.lsp_references()
        end,
        desc = "References (Snacks Picker)",
      },
      {
        "<leader>fl",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "Lazy Plugins",
      },
      {
        "<leader>lg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
      -- {
      --   "<leader>gl",
      --   function()
      --     require("snacks").lazygit.log()
      --   end,
      --   desc = "Lazygit Logs",
      -- },
      {
        "z=",
        function()
          require("snacks").picker.spelling { layout = { preset = "default", preview = false } }
        end,
        desc = "Fast Rename Current File",
      },

      {
        "<leader>uc",
        function()
          require("snacks").picker.colorschemes {
            on_close = function()
              local cs = vim.g.colors_name
              if not cs then
                return
              end

              local path = vim.fn.stdpath "config" .. "/lua/core/colorscheme.lua"
              local lines = {
                string.format('vim.cmd.colorscheme("%s")', cs),
              }

              vim.fn.writefile(lines, path)
              vim.notify("Saved colorscheme: " .. cs)
            end,
          }
        end,
        desc = "Colorschemes (persist)",
      },
      {
        "<leader>rf",
        function()
          require("snacks").rename.rename_file()
        end,
        desc = "Fast Rename Current File",
      },
      {
        "<leader>dB",
        function()
          require("snacks").bufdelete()
        end,
        desc = "Delete or Close Buffer  (Confirm)",
      },

      -- Snacks Picker
      {
        "<leader>pf",
        function()
          require("snacks").picker.files()
        end,
        desc = "Find Files (Snacks Picker)",
      },
      {
        "<leader>pc",
        function()
          require("snacks").picker.files { cwd = vim.fn.stdpath "config" }
        end,
        desc = "Find Config File",
      },
      {
        "<leader>fo",
        function()
          require("snacks").picker.recent()
        end,
        desc = "Grep word",
      },
      {
        "<leader>ff",
        function()
          require("snacks").picker.smart()
        end,
        desc = "Grep word",
      },
      {
        "<leader>fw",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Grep word",
      },
      {
        "<leader>pws",
        function()
          require("snacks").picker.grep_word()
        end,
        desc = "Search Visual selection or Word",
        mode = { "n", "x" },
      },

      -- {
      --   "<C-/>",
      --   function()
      --     require("snacks").terminal.toggle()
      --   end,
      --   desc = "Search Keymaps (Snacks Picker)",
      -- },
      {
        "<leader>fi",
        function()
          -- require("snacks").picker.icons {
          --   -- layout = {
          --   --   preview = "preview",
          --   --   preset = "dropdown",
          --   -- },
          -- }
          require("snacks").picker.icons {
            sources = {
              -- "nerd fonts", -- Nerd Font icons
              -- "emoji", -- 🚫 disable emojis
            },
          }
        end,
        desc = "Search Icons (Snacks Picker)",
      },
      {
        "<leader>pk",
        function()
          require("snacks").picker.keymaps {
            layout = {
              preview = "preview",
              preset = "dropdown",
            },
          }
        end,
        desc = "Search Keymaps (Snacks Picker)",
      },

      -- Git Stuff
      -- {
      --   "<leader>gbr",
      --   function()
      --     require("snacks").picker.git_branches { layout = "select" }
      --   end,
      --   desc = "Pick and Switch Git Branches",
      -- },

      -- Other Utils
      -- {
      --   "<leader>th",
      --   function()
      --     require("snacks").picker.colorschemes { layout = "ivy" }
      --   end,
      --   desc = "Pick Color Schemes",
      -- },
      {
        "<leader>ca",
        function()
          require("snacks").picker.qflist()
        end,
        desc = "Todo",
      },
      {
        "<leader>h",
        function()
          require("snacks").picker.help()
        end,
        desc = "Help Pages",
      },
    },
  },
  -- NOTE: todo comments w/ snacks
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    optional = true,
    keys = {

      {
        "<leader>pt",
        function()
          require("snacks").picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>pT",
        function()
          require("snacks").picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } }
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
