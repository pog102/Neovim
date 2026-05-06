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
  "NoiceCmdlinePopup",
  "NoiceCmdlinePopupBorder",
  "NoicePopup",
  "NoicePopupBorder",
  "NoiceSplit",
  "NoiceSplitBorder",

  -- snacks picker
  -- "SnacksPicker",
  -- "SnacksPickerBorder",
  -- "SnacksPickerTitle",
  -- "SnacksPickerCursorLine", -- selected item
  -- "SnacksPickerPreview",
  -- "SnacksPickerPreviewBorder",
      -- messages / errors
  -- "NoiceFormatError",
  -- "NoiceFormatWarning",
  -- "NoiceFormatInfo",
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end
