-- local colors = require('hellwal')
local colors = dofile(os.getenv "HOME" .. "/.cache/hellwal/colors.lua")

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Helper function
local function hi(group, opts)
  -- auto-convert transparent
  if opts.bg == colors.background then
    opts.bg = "NONE"
    -- elseif opts.fg == colors.background then
    --   opts.fg = "NONE"
  end
  vim.api.nvim_set_hl(0, group, opts)
end

-- Highlights table
local highlights = {
  Normal = { fg = colors.foreground, bg = colors.background },
  StatusLineNC = { bg = colors.background, fg = colors.background },
  StatusLine = { bg = colors.background, fg = colors.background },
  SignColumn = { bg = colors.background, fg = colors.background },
  MsgArea = { fg = colors.foreground, bg = colors.background },
  ModeMsg = { fg = colors.foreground, bg = colors.background },
  MsgSeparator = { fg = colors.foreground, bg = colors.background },
  SpellBad = { fg = colors.color2 },
  SpellCap = { fg = colors.color6 },
  SpellLocal = { fg = colors.color4 },
  SpellRare = { fg = colors.color6 },
  NormalNC = { fg = colors.foreground, bg = colors.background },
  Pmenu = { fg = colors.foreground, bg = colors.background },
  PmenuSel = { fg = colors.background, bg = colors.color4 },
  WildMenu = { fg = colors.color7, bg = colors.color4 },
  CursorLineNr = { fg = colors.color1 },
  Comment = { fg = colors.color13 },
  Folded = { fg = colors.color4, bg = colors.background },
  FoldColumn = { fg = colors.color4, bg = colors.background },
  LineNr = { fg = colors.color12, bg = colors.background },
  FloatBorder = { fg = colors.foreground, bg = colors.background },
  Whitespace = { fg = colors.color1 },
  VertSplit = { fg = colors.background, bg = colors.color1 },
  CursorLine = { bg = colors.background },
  CursorColumn = { bg = colors.background },
  ColorColumn = { bg = colors.background },
  NormalFloat = { bg = colors.background },
  Visual = { bg = colors.color1, fg = colors.foreground },
  VisualNOS = { bg = colors.background },
  WarningMsg = { fg = colors.color3, bg = colors.background },
  DiffAdd = { fg = colors.background, bg = colors.color4 },
  DiffChange = { fg = colors.background, bg = colors.color5 },
  DiffDelete = { fg = colors.background, bg = colors.color11 },
  QuickFixLine = { bg = colors.color2 },
  PmenuSbar = { bg = colors.background },
  PmenuThumb = { bg = colors.color2 },
  MatchParen = { fg = colors.color4, bg = colors.background },
  Cursor = { fg = colors.foreground, bg = colors.cursor },
  lCursor = { fg = colors.foreground, bg = colors.cursor },
  CursorIM = { fg = colors.foreground, bg = colors.cursor },
  TermCursor = { fg = colors.foreground, bg = colors.cursor },
  TermCursorNC = { fg = colors.foreground, bg = colors.cursor },
  Conceal = { fg = colors.color4, bg = colors.background },
  Directory = { fg = colors.color4 },
  SpecialKey = { fg = colors.color4 },
  Title = { fg = colors.color4 },
  ErrorMsg = { fg = colors.color11, bg = colors.background },
  Search = { fg = colors.foreground, bg = colors.color1 },
  IncSearch = { fg = colors.foreground, bg = colors.color1 },
  Substitute = { fg = colors.color1, bg = colors.color6 },
  MoreMsg = { fg = colors.color5 },
  Question = { fg = colors.color5 },
  EndOfBuffer = { fg = colors.background },
  NonText = { fg = colors.foreground },
  Variable = { fg = colors.color5 },
  String = { fg = colors.color12 },
  Character = { fg = colors.color12 },
  Constant = { fg = colors.color5 },
  Number = { fg = colors.color5 },
  Boolean = { fg = colors.color3 },
  Float = { fg = colors.color5 },
  Identifier = { fg = colors.color5 },
  Function = { fg = colors.color11 },
  Operator = { fg = colors.color3 },
  Type = { fg = colors.color5 },
  StorageClass = { fg = colors.color7 },
  Structure = { fg = colors.color6 },
  Typedef = { fg = colors.color6 },
  Keyword = { fg = colors.color6 },
  Statement = { fg = colors.color6 },
  Conditional = { fg = colors.color6 },
  Repeat = { fg = colors.color6 },
  Label = { fg = colors.color4 },
  Exception = { fg = colors.color6 },
  Include = { fg = colors.color6 },
  PreProc = { fg = colors.color6 },
  Define = { fg = colors.color6 },
  Macro = { fg = colors.color6 },
  PreCondit = { fg = colors.color6 },
  Special = { fg = colors.color14 },
  SpecialChar = { fg = colors.foreground },
  Tag = { fg = colors.color4 },
  Debug = { fg = colors.color11 },
  Delimiter = { fg = colors.foreground },
  SpecialComment = { fg = colors.color2 },
  Ignore = { fg = colors.color7, bg = colors.background },
  Todo = { fg = colors.color11, bg = colors.background },
  Error = { fg = colors.color11, bg = colors.background },
  -- You can continue with all the others...
  TabLine = { fg = colors.color2, bg = colors.background },
  TabLineSel = { fg = colors.foreground, bg = colors.background },
  TabLineFill = { fg = colors.foreground, bg = colors.background },

  BufferCurrent = { fg = colors.foreground, bg = colors.background },
  BufferCurrentIndex = { fg = colors.foreground, bg = colors.background },
  BufferCurrentMod = { fg = colors.color4, bg = colors.background },
  BufferCurrentSign = { fg = colors.color4, bg = colors.background },
  BufferCurrentTarget = { fg = colors.color3, bg = colors.background },

  BufferVisible = { fg = colors.color7, bg = colors.background },
  BufferVisibleIndex = { fg = colors.color7, bg = colors.background },
  BufferVisibleMod = { fg = colors.color4, bg = colors.background },
  BufferVisibleSign = { fg = colors.color9, bg = colors.background },
  BufferVisibleTarget = { fg = colors.color3, bg = colors.background },

  BufferInactive = { fg = colors.color9, bg = colors.background },
  BufferInactiveIndex = { fg = colors.color9, bg = colors.background },
  -- BufferInactiveMod = { fg = "NONE", bg = colors.background },
  BufferInactiveSign = { fg = "NONE", bg = colors.background },
  -- BufferInactiveSign = { fg = colors.color14, bg = colors.background },
  -- BufferInactiveTarget = { fg = colors.color3, bg = colors.background },

  BufferTabpages = { fg = colors.color4, bg = colors.background },
  BufferTabpageFill = { fg = colors.foreground, bg = colors.background },
  BufferOffset = { fg = colors.color5, bg = colors.background },
  BufferScrollArrow = { fg = colors.color4, bg = colors.background },

  BufferPart = { fg = colors.foreground, bg = colors.background },
  -- CmpItemMenuDefault = { fg = colors.color1, bg = colors.background },
  -- CmpItemMenu = { fg = colors.color1, bg = colors.background },

  -- TelescopeResultsDiffUntracked = { fg = colors.color15, bg = colors.background },
  -- Blinl cmp
  BlinkCmpLabel = { fg = colors.color4 },
  BlinkCmpLabelDeprecated = { fg = colors.color2 },
  BlinkCmpKind = { fg = colors.color6 },
  -- BlinkCmpMenu               = { link = "Pmenu" },
  BlinkCmpLabelMatch = { fg = colors.foreground },
  BlinkCmpMenuSelection = { bg = colors.color1 },
  BlinkCmpScrollBarGutter = { bg = colors.color1 },
  BlinkCmpScrollBarThumb = { bg = colors.color2 },
  BlinkCmpLabelDescription = { fg = colors.color2 },
  BlinkCmpLabelDetail = { fg = colors.color2 },

  NoiceCmdlinePopupBorder = { fg = colors.foreground },

  BlinkCmpKindText = { fg = colors.color4 },
  BlinkCmpKindMethod = { fg = colors.color6 },
  BlinkCmpKindFunction = { fg = colors.color6 },
  BlinkCmpKindConstructor = { fg = colors.color6 },
  BlinkCmpKindField = { fg = colors.color4 },
  BlinkCmpKindVariable = { fg = colors.color3 },
  BlinkCmpKindClass = { fg = colors.color5 },
  BlinkCmpKindInterface = { fg = colors.color5 },
  BlinkCmpKindModule = { fg = colors.color6 },
  BlinkCmpKindProperty = { fg = colors.color6 },
  BlinkCmpKindUnit = { fg = colors.color4 },
  BlinkCmpKindValue = { fg = colors.color5 },
  BlinkCmpKindEnum = { fg = colors.color5 },
  BlinkCmpKindKeyword = { fg = colors.color7 },
  BlinkCmpKindSnippet = { fg = colors.color3 },
  BlinkCmpKindColor = { fg = colors.color1 },
  BlinkCmpKindFile = { fg = colors.color6 },
  BlinkCmpKindReference = { fg = colors.color1 },
  BlinkCmpKindFolder = { fg = colors.color6 },
  BlinkCmpKindEnumMember = { fg = colors.color8 },
  BlinkCmpKindConstant = { fg = colors.color5 },
  BlinkCmpKindStruct = { fg = colors.color6 },
  BlinkCmpKindEvent = { fg = colors.color6 },
  BlinkCmpKindOperator = { fg = colors.color7 },
  BlinkCmpKindTypeParameter = { fg = colors.color4 },
  BlinkCmpKindCopilot = { fg = colors.color8 },
}

-- Treesitter example additions
-- highlights.TSComment = { fg = colors.color13 }
-- highlights.TSNote = { fg = colors.background, bg = colors.color5 }
-- highlights.TSWarning = { fg = colors.background, bg = colors.color5 }
-- highlights.TSDanger = { fg = colors.background, bg = colors.color3 }
-- highlights.TSConstructor = { fg = colors.color6 }

for group, opts in pairs(highlights) do
  hi(group, opts)
end

-- lualine
local lualine_theme = {
  normal = {
    a = { fg = colors.background, bg = colors.color2, bold = true }, -- mode indicator
    b = { fg = colors.foreground, bg = colors.color0 },
    c = { fg = colors.foreground, bg = colors.background },
  },
  insert = {
    a = { fg = colors.background, bg = colors.color4, bold = true },
    b = { fg = colors.foreground, bg = colors.color0 },
    c = { fg = colors.foreground, bg = colors.background },
  },
  visual = {
    a = { fg = colors.background, bg = colors.color6, bold = true },
    b = { fg = colors.foreground, bg = colors.color0 },
    c = { fg = colors.foreground, bg = colors.background },
  },
  replace = {
    a = { fg = colors.background, bg = colors.color1, bold = true },
    b = { fg = colors.foreground, bg = colors.color0 },
    c = { fg = colors.foreground, bg = colors.background },
  },
  command = {
    a = { fg = colors.background, bg = colors.color5, bold = true },
    b = { fg = colors.foreground, bg = colors.color0 },
    c = { fg = colors.foreground, bg = colors.background },
  },
  inactive = {
    a = { fg = colors.color8, bg = colors.color0, bold = true },
    b = { fg = colors.color8, bg = colors.color0 },
    c = { fg = colors.color8, bg = colors.color0 },
  },
}
local lualine = require "lualine"

lualine.setup {
  options = {
    theme = lualine_theme,
  },
}
