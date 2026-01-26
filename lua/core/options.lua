vim.opt.spelllang = { "lt" }
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "Red" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
if vim.fn.has "win32" == 1 then
  vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
end
-- vim.g.neovide_padding_top = 20
vim.g.neovide_padding_bottom = 20
vim.g.neovide_padding_right = 20
vim.g.neovide_padding_left = 20
vim.opt.guifont = "Hack Nerd Font Propo:h14"
-- if vim.g.neovide then
--   -- Put anything you want to happen only in Neovide here
-- end
vim.cmd "let g:netrw_banner = 0 "
vim.opt.nu = true
vim.opt.autochdir = true
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
local undodir_path
if vim.fn.has "win32" == 1 then
  undodir_path = os.getenv "LOCALAPPDATA" .. "/nvim-data/undodir"
else
  undodir_path = os.getenv "HOME" .. "/.vim/undodir"
end

vim.opt.undodir = undodir_path
if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, "p")
end
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"
-- vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.fillchars:append { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
-- vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- backspace
vim.opt.backspace = { "start", "eol", "indent" }
-- clipboard
vim.opt.clipboard:append "unnamedplus" --use system clipboard as default
vim.opt.hlsearch = true

-- for easy mouse resizing, just incase
vim.opt.mouse = "a"

-- gets rid of line with white spaces
vim.g.editorconfig = true

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--
-- -- Hide the fold column to reduce clutter
-- vim.opt.foldcolumn = "0"
--
-- -- Keep original fold text syntax highlighted
-- vim.opt.foldtext = ""
--
-- -- Control default fold depth on open
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 1
--
-- -- Limit how deep nested folds go
-- vim.opt.foldnestmax = 4
-- Create symmetrical `$$` pair only in Tex files
-- autoformat
-- local format_on_save_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = format_on_save_group,
--   pattern = "*",
--   callback = function()
--     vim.lsp.buf.format({ async = true })
--   end,
-- })
-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})
-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})
-- ide like highlight when stopping cursor
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
--   desc = "Highlight references under cursor",
--   callback = function()
--     -- Only run if the cursor is not in insert mode
--     if vim.fn.mode() ~= "i" then
--       local clients = vim.lsp.get_clients { bufnr = 0 }
--       local supports_highlight = false
--       for _, client in ipairs(clients) do
--         if client.server_capabilities.documentHighlightProvider then
--           supports_highlight = true
--           break -- Found a supporting client, no need to check others
--         end
--       end
--
--       -- 3. Proceed only if an LSP is active AND supports the feature
--       if supports_highlight then
--         vim.lsp.buf.clear_references()
--         vim.lsp.buf.document_highlight()
--       end
--     end
--   end,
-- })
-- -- ide like highlight when stopping cursor
-- vim.api.nvim_create_autocmd("CursorMovedI", {
--   group = "LspReferenceHighlight",
--   desc = "Clear highlights when entering insert mode",
--   callback = function()
--     vim.lsp.buf.clear_references()
--   end,
-- })
