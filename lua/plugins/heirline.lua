return {
  "rebelot/heirline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>") -- show definition, references
    vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>") -- show definition, references
    vim.keymap.set("n", "<A-q>", "<cmd>bdelete<CR>") -- show definition, references
    -- local colors = require("tokyonight.colors").setup() -- wink
    -- local conditions = require "heirline.conditions"
    local conditions = require "heirline.conditions"
    local utils = require "heirline.utils"
    -- local TablineBufnr = {
    --   provider = function(self)
    --     return tostring(self.bufnr) .. ". "
    --   end,
    --   hl = "Comment",
    -- }
    --
    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }
    -- we redefine the filename component, as we probably only want the tail and not the relative path
    local TablineFileName = {
      provider = function(self)
        -- self.filename will be defined later, just keep looking at the example!
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
      end,
      hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
      end,
    }

    -- this looks exactly like the FileFlags component that we saw in
    -- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
    -- also, we are adding a nice icon for terminal buffers.
    local TablineFileFlags = {
      {
        condition = function(self)
          return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        end,
        provider = "  ",
        hl = { fg = "green" },
      },
      {
        condition = function(self)
          return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
            or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
        end,
        provider = function(self)
          if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
            return "  "
          else
            return ""
          end
        end,
        hl = { fg = "orange" },
      },
    }

    -- Here the filename block finally comes together
    local TablineFileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      end,
      hl = function(self)
        if self.is_active then
          return "TabLineSel"
        -- why not?
        -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
        --     return { fg = "gray" }
        else
          return "TabLine"
          -- return "NONE"
        end
      end,
      on_click = {
        callback = function(_, minwid, _, button)
          if button == "m" then -- close on mouse middle click
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = false })
            end)
          else
            vim.api.nvim_win_set_buf(0, minwid)
          end
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
      },
      -- TablineBufnr,
      FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
      TablineFileName,
      TablineFileFlags,
    }
    local CodeCompanion = {
      static = {
        processing = false,
      },
      update = {
        "User",
        pattern = "CodeCompanionRequest*",
        callback = function(self, args)
          if args.match == "CodeCompanionRequestStarted" then
            self.processing = true
          elseif args.match == "CodeCompanionRequestFinished" then
            self.processing = false
          end
          vim.cmd "redrawstatus"
        end,
      },
      {
        condition = function(self)
          return self.processing
        end,
        provider = " ",
        hl = { fg = "yellow" },
      },
    }

    local IsCodeCompanion = function()
      return package.loaded.codecompanion and vim.bo.filetype == "codecompanion"
    end

    local CodeCompanionCurrentContext = {
      static = {
        enabled = true,
      },
      condition = function(self)
        return IsCodeCompanion() and _G.codecompanion_current_context ~= nil and self.enabled
      end,
      provider = function()
        local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(_G.codecompanion_current_context), ":t")
        return "[  " .. bufname .. " ] "
      end,
      hl = { fg = "gray", bg = "bg" },
      update = {
        "User",
        pattern = { "CodeCompanionRequest*", "CodeCompanionContextChanged" },
        callback = vim.schedule_wrap(function(self, args)
          if args.match == "CodeCompanionRequestStarted" then
            self.enabled = false
          elseif args.match == "CodeCompanionRequestFinished" then
            self.enabled = true
          end
          vim.cmd "redrawstatus"
        end),
      },
    }

    local CodeCompanionStats = {
      condition = function(self)
        return IsCodeCompanion()
      end,
      static = {
        chat_values = {},
      },
      init = function(self)
        local bufnr = vim.api.nvim_get_current_buf()
        self.chat_values = _G.codecompanion_chat_metadata[bufnr]
      end,
      -- Tokens block
      {
        condition = function(self)
          return self.chat_values.tokens > 0
        end,
        RightSlantStart,
        {
          provider = function(self)
            return "   " .. self.chat_values.tokens .. " "
          end,
          hl = { fg = "gray", bg = "statusline_bg" },
          update = {
            "User",
            pattern = { "CodeCompanionChatOpened", "CodeCompanionRequestFinished" },
            callback = vim.schedule_wrap(function()
              vim.cmd "redrawstatus"
            end),
          },
        },
        RightSlantEnd,
      },
      -- Cycles block
      {
        condition = function(self)
          return self.chat_values.cycles > 0
        end,
        RightSlantStart,
        {
          provider = function(self)
            return "  " .. self.chat_values.cycles .. " "
          end,
          hl = { fg = "gray", bg = "statusline_bg" },
          update = {
            "User",
            pattern = { "CodeCompanionChatOpened", "CodeCompanionRequestFinished" },
            callback = vim.schedule_wrap(function()
              vim.cmd "redrawstatus"
            end),
          },
        },
        RightSlantEnd,
      },
    }
    -- a nice "x" button to close the buffer
    local TablineCloseButton = {
      condition = function(self)
        return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      end,
      { provider = " " },
      {
        provider = " ",
        hl = { fg = "gray" },
        on_click = {
          callback = function(_, minwid)
            vim.schedule(function()
              vim.api.nvim_buf_delete(minwid, { force = false })
              vim.cmd.redrawtabline()
            end)
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "heirline_tabline_close_buffer_callback",
        },
      },
    }

    -- The final touch!
    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
      if self.is_active then
        return utils.get_highlight("TabLineSel").bg
        -- return utils.get_highlight("NONE").bg
      else
        -- return "NONE"
        return utils.get_highlight("TabLine").bg
        -- return utils.get_highlight("TabLine").bg
      end
    end, { TablineFileNameBlock, TablineCloseButton })

    -- and here we go
    -- this is the default function used to retrieve buffers
    local get_bufs = function()
      return vim.tbl_filter(function(bufnr)
        return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      end, vim.api.nvim_list_bufs())
    end

    -- initialize the buflist cache
    local buflist_cache = {}

    -- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
    vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          local buffers = get_bufs()
          for i, v in ipairs(buffers) do
            buflist_cache[i] = v
          end
          for i = #buffers + 1, #buflist_cache do
            buflist_cache[i] = nil
          end

          -- check how many buffers we have and set showtabline accordingly
          if #buflist_cache > 1 then
            vim.o.showtabline = 2 -- always
          elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
            vim.o.showtabline = 1 -- only when #tabpages > 1
          end
        end)
      end,
    })

    local BufferLine = utils.make_buflist(
      TablineBufferBlock,
      { provider = " ", hl = { fg = "gray" } },
      { provider = " ", hl = { fg = "gray" } },
      -- out buf_func simply returns the buflist_cache
      function()
        return buflist_cache
      end,
      -- no cache, as we're handling everything ourselves
      false
    )
    local ViMode = {
      -- get vim current mode, this information will be required by the provider
      -- and the highlight functions, so we compute it only once per component
      -- evaluation and store it as a component attribute
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      -- Now we define some dictionaries to map the output of mode() to the
      -- corresponding string and color. We can put these into `static` to compute
      -- them at initialisation time.
      ----------------------- STATUS LINE BEGIN ----------------------------------------
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "N",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "V",
          vs = "Vs",
          V = "V_",
          Vs = "Vs",
          ["\22"] = "^V",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "I",
          ic = "Ic",
          ix = "Ix",
          R = "R",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "C",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
        mode_colors = {
          n = "red",
          i = "green",
          v = "cyan",
          V = "cyan",
          ["\22"] = "cyan",
          c = "orange",
          s = "purple",
          S = "purple",
          ["\19"] = "purple",
          R = "orange",
          r = "orange",
          ["!"] = "red",
          t = "red",
        },
      },
      -- We can now access the value of mode() that, by now, would have been
      -- computed by `init()` and use it to index our strings dictionary.
      -- note how `static` fields become just regular attributes once the
      -- component is instantiated.
      -- To be extra meticulous, we can also add some vim statusline syntax to
      -- control the padding and make sure our string is always at least 2
      -- characters long. Plus a nice Icon.
      provider = function(self)
        return " %2(" .. self.mode_names[self.mode] .. "%)"
      end,
      -- Same goes for the highlight. Now the foreground will change according to the current mode.
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bold = true }
      end,
      -- Re-evaluate the component only on ModeChanged event!
      -- Also allows the statusline to be re-evaluated when entering operator-pending mode
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd "redrawstatus"
        end),
      },
    }
    ----------------------- STATUS LINE END ----------------------------------------
    ----------------------- FILENAME ----------------------------------------
    ---
    local FileNameBlock = {
      -- let's first set up some attributes needed by this component and its children
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }
    -- We can now define some children separately and add them later

    local FileName = {
      provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
          return "[No Name]"
        end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight("Directory").fg },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = "  ",
        hl = { fg = "green" },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
      },
    }

    -- Now, let's say that we want the filename color to change if the buffer is
    -- modified. Of course, we could do that directly using the FileName.hl field,
    -- but we'll see how easy it is to alter existing components using a "modifier"
    -- component

    local FileNameModifer = {
      hl = function()
        if vim.bo.modified then
          -- use `force` because we need to override the child's hl foreground
          return { fg = "cyan", bold = true, force = true }
        end
      end,
    }

    -- let's add the children to our FileNameBlock component
    FileNameBlock = utils.insert(
      FileNameBlock,
      FileIcon,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
      FileFlags,
      { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
    )
    ----------------------- FILENAME END ----------------------------------------
    local LSPActive = {
      on_click = {
        callback = function()
          vim.defer_fn(function()
            vim.cmd "LspInfo"
          end, 100)
        end,
        name = "heirline_LSP",
      },
      condition = conditions.lsp_attached,
      update = { "LspAttach", "LspDetach" },

      -- You can keep it simple,
      -- provider = " [LSP]",

      -- Or complicate things a bit and get the servers names
      provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
      end,
      hl = { fg = "green", bold = true },
    }
    -- local Snippets = {
    --   -- check that we are in insert or select mode
    --   condition = function()
    --     return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
    --   end,
    --   provider = function()
    --     local forward = (vim.fn["UltiSnips#CanJumpForwards"]() == 1) and "" or ""
    --     local backward = (vim.fn["UltiSnips#CanJumpBackwards"]() == 1) and " " or ""
    --     return backward .. forward
    --   end,
    --   hl = { fg = "red", bold = true },
    -- }
    -- vim.diagnostic.config {
    --   signs = {
    --     text = {
    --       [vim.diagnostic.severity.ERROR] = " ",
    --       [vim.diagnostic.severity.WARN] = " ",
    --       [vim.diagnostic.severity.HINT] = "󰠠 ",
    --       [vim.diagnostic.severity.INFO] = " ",
    --     },
    --   },
    -- }
    local Notifications = {
      provider = " ", -- save icon
      hl = { fg = "blue" },

      on_click = {
        callback = function()
          require("snacks").picker.notifications { confirm = { "yank", "close" } }
          -- require("snacks").picker.notifications {}
        end,
        name = "heirline_notifications",
      },
    }
    local Diagnostics = {

      condition = conditions.has_diagnostics,

      static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = "󰠠 ",
      },

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      on_click = {
        callback = function()
          -- require("trouble").toggle { mode = "document_diagnostics" }
          require("snacks").picker.diagnostics_buffer()
          -- or
          -- vim.diagnostic.setqflist()
        end,
        name = "heirline_diagnostics",
      },
      update = { "DiagnosticChanged", "BufEnter" },
      {
        provider = function(self)
          return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = "DiagnosticError",
      },
      {
        provider = function(self)
          return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = "DiagnosticWarn",
      },
      {
        provider = function(self)
          return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = "DiagnosticInfo",
      },
      {
        provider = function(self)
          return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
        end,
        hl = "DiagnosticHint",
      },
    }
    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,

      hl = { fg = "orange" },

      { -- git branch name
        provider = function(self)
          return " " .. self.status_dict.head .. " "
        end,
        hl = { bold = true },
      },
      -- You could handle delimiters, icons and counts similar to Diagnostics
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and (" " .. count .. " ")
        end,
        hl = { fg = "git_add" },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and (" " .. count .. " ")
        end,
        hl = { fg = "git_del" },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and (" " .. count .. " ")
        end,
        hl = { fg = "git_change" },
      },
      on_click = {
        callback = function()
          -- vim.defer_fn(function()
          require("snacks").lazygit()
          -- vim.cmd "Lazygit"
          -- require("snacks").lazygit.open() --{ focus = true }
          -- end, 100)
        end,
        name = "heirline_git",
      },
    }

    local TabLineOffset = {
      condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        -- if vim.bo[bufnr].filetype == "NvimTree" then
        --   self.title = "NvimTree"
        --   return true
        --   -- elseif vim.bo[bufnr].filetype == "TagBar" then
        --   --     ...
        -- end
      end,

      provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
      end,
      -- FIN: make transparentt
      hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
          return "TablineSel"
        else
          -- return "Tabline"
          return "Tabline"
        end
      end,
    }
    local colors = {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("diffDeleted").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      git_change = utils.get_highlight("diffChanged").fg,
    }
    --
    -- local SessionSave = {
    --   provider = " ", -- save icon
    --   hl = { fg = "blue" },
    --
    --   on_click = {
    --     callback = function()
    --       require("mini.sessions").write "Session"
    --     end,
    --     name = "heirline_session_save",
    --   },
    -- }
    local Tabpage = {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      end,
      hl = function(self)
        if not self.is_active then
          return "TabLine"
        else
          return "TabLineSel"
        end
      end,
    }

    local TabpageClose = {
      provider = "%999X  %X",
      hl = "TabLine",
    }

    local TabPages = {
      -- only show this component if there's 2 or more tabpages
      condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
      end,
      { provider = "%=" },
      utils.make_tablist(Tabpage),
      TabpageClose,
    }

    local Space = { provider = " " }
    local Align = { provider = "%=" }
    ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })
    -- require("heirline").load_colors(colors)
    -- ViMode = utils.surround({ "", "" }, colors.bright_bg, { ViMode })
    local StatusLine = {
      ViMode,
      Space,
      FileNameBlock,
      Space,
      Diagnostics,
      Space,
      Git,
      Align,
      Notifications,
      Space,
      CodeCompanion,
      Space,
      LSPActive,
    }
    -- TODO: TabLineOffset
    local TabLine = { TabLineOffset, BufferLine, TabPages }
    -- local BufferLine = utils.make_buflist(
    --   TablineBufferBlock,
    --   { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    --   { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    --   -- by the way, open a lot of buffers and try clicking them ;)
    -- )
    require("heirline").setup {
      statusline = StatusLine,
      tabline = TabLine,
      -- winbar = BufferLine,
      -- winbar = WinBars,
      -- winbar = TabLine,
      opts = {
        colors = colors,
      },
    }
    vim.o.showtabline = 2
    vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]

    local function setup_colors()
      return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
      }
    end
    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(setup_colors)
      end,
      group = "Heirline",
    })
  end,
}
