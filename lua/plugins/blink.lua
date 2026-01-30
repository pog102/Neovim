return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind.nvim",
    -- "xzbdmw/colorful-menu.nvim",
    -- "onsails/lspkind.nvim", -- vs-code pictograms
  },
  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item

    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
            },
          },
          -- padding = { 0, 1 }, -- padding only on right side
          -- components = {
          --   kind_icon = {
          --     text = function(ctx)
          --       return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
          --     end,
          --   },
          -- },
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
        },
        -- draw = {
        --   components = {
        --     kind_icon = {
        --       text = function(ctx)
        --         local icon = ctx.kind_icon
        --         if vim.tbl_contains({ "Path" }, ctx.source_name) then
        --           local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
        --           if dev_icon then
        --             icon = dev_icon
        --           end
        --         else
        --           icon = require("lspkind").symbolic(ctx.kind, {
        --             mode = "symbol",
        --           })
        --         end
        --
        --         return icon .. ctx.icon_gap
        --       end,
        --
        --       -- Optionally, use the highlight groups from nvim-web-devicons
        --       -- You can also add the same function for `kind.highlight` if you want to
        --       -- keep the highlight groups in sync with the icons.
        --       -- highlight = function(ctx)
        --       --   local hl = ctx.kind_hl
        --       --   if vim.tbl_contains({ "Path" }, ctx.source_name) then
        --       --     local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
        --       --     if dev_icon then
        --       --       hl = dev_hl
        --       --     end
        --       --   end
        --       --   return hl
        --       -- end,
        --     },
        --   },
        -- },
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
      documentation = {
        auto_show_delay_ms = 0,
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
    },
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    signature = { enabled = false },
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<Enter>"] = { "select_and_accept", "fallback" },
    },

    -- appearance = {
    --   -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --   -- Adjusts spacing to ensure icons are aligned
    --   nerd_font_variant = "mono",
    -- },
    appearance = {
      kind_icons = {
        use = "devicons", -- 👈 THIS is the new API
      },
    },
    -- (Default) Only show the documentation popup when manually triggered

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },

  opts_extend = { "sources.default" },
}
