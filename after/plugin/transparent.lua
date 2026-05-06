local transparent_groups = {
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "SignColumn",
  "VertSplit",
  "StatusLine",
  "StatusLineNC",
  -- "TabLine",
  "TabLineFill",
  -- "TabLineSel",

    "MiniFilesNormal",
  "MiniFilesBorder",
  "MiniFilesTitle",
  "MiniFilesTitleFocused",
    "MiniFilesCursorLine", -- 👈 selected line
 -- noice
"GitGutterAdd", "GitGutterChange", "GitGutterDelete",
  "NoiceCmdlinePopup",
  "NoiceCmdlinePopupBorder",
  "NoicePopup",
  "NoicePopupBorder",
  "NoiceSplit",
  "NoiceSplitBorder",
  "FloatNormal", "FloatBorder","NormalFloat",
-- "PmenuKind",
    'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'CursorLine', 'CursorLineNr',
    'EndOfBuffer',
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none",ctermbg = "none" })
end
