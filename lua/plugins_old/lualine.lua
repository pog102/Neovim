return {
    enabled=false,
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require "lualine"
    local lazy_status = require "lazy.status" -- to configure lazy pending updates count

    local M = require("lualine.component"):extend()

    M.processing = false
    M.spinner_index = 1

    local spinner_symbols = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    }
    local spinner_symbols_len = 10

    -- Initializer
    function M:init(options)
      M.super.init(self, options)

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
          if request.match == "CodeCompanionRequestStarted" then
            self.processing = true
          elseif request.match == "CodeCompanionRequestFinished" then
            self.processing = false
          end
        end,
      })
    end

    -- Function that runs every time statusline is updated
    function M:update_status()
      if self.processing then
        self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
        return spinner_symbols[self.spinner_index]
      else
        return nil
      end
    end
    --
    -- return M
    -- local colors = {
    --           color0 = "#092236",
    --           color1 = "#ff5874",
    --           color2 = "#c3ccdc",
    -- 	color3 = "#1c1e26",
    -- 	color6 = "#a1aab8",
    -- 	color7 = "#828697",
    -- 	color8 = "#ae81ff",
    -- }
    -- local my_lualine_theme = {
    -- 	replace = {
    -- 		a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
    -- 		b = { fg = colors.color2, bg = colors.color3 },
    -- 	},
    -- 	inactive = {
    -- 		a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
    -- 		b = { fg = colors.color6, bg = colors.color3 },
    -- 		c = { fg = colors.color6, bg = colors.color3 },
    -- 	},
    -- 	normal = {
    -- 		a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
    -- 		b = { fg = colors.color2, bg = colors.color3 },
    -- 		c = { fg = colors.color2, bg = colors.color3 },
    -- 	},
    -- 	visual = {
    -- 		a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
    -- 		b = { fg = colors.color2, bg = colors.color3 },
    -- 	},
    -- 	insert = {
    -- 		a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
    -- 		b = { fg = colors.color2, bg = colors.color3 },
    -- 	},
    -- }
    --
    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
      end,
    }
    --
    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      -- cond = hide_in_width,
    }
    --
    --       local filename = {
    --           'filename',
    --           file_status = true,
    --           path = 0,
    --       }
    --
    --       local branch = {'branch', icon = {'', color={fg='#A6D4DE'}}, '|'}

    lualine.setup {
      icons_enabled = true,
      options = {
        -- theme = my_lualine_theme,
        component_separators = { left = "", right = "" },
        -- theme = "hellwal",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          mode,
        },
        lualine_b = { "branch", diff, "diagnostics" },
        lualine_c = {
          "filename",
          M,
          {
            function()
              if vim.loop.getuid() == 0 then
                return ""
              end
              return ""
            end,
            color = { fg = "#ff0000" },
          },
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      -- sections = {
      --             lualine_a = { mode },
      --             lualine_b = { branch },
      --             lualine_c = { diff, filename },
      -- lualine_x = {
      -- 	{
      --                     -- require("noice").api.statusline.mode.get,
      --                     -- cond = require("noice").api.statusline.mode.has,
      -- 		lazy_status.updates,
      -- 		cond = lazy_status.has_updates,
      -- 		color = { fg = "#ff9e64" },
      -- 	},
      -- 	-- { "encoding",},
      -- 	-- { "fileformat" },
      -- 	{ "filetype" },
      -- },
      -- },
    }
  end,
}
