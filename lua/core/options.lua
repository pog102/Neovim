vim.opt.spelllang = { "lt" }
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "Red" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

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
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd "wincmd L" -- move help window to right first
      -- vim.cmd "wincmd H" -- then move it to the left
      vim.cmd "vertical resize 80" -- optional: set a good width
    end
  end,
})
