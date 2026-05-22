vim.opt.spelllang = { "lt", "en" }
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "Red" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
-- if vim.fn.has "win32" == 1 then
--   vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
-- end
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

vim.opt.cursorline = true -- Enable cursor line highlighting
vim.opt.cursorlineopt = "number" -- Highlights both the line and the number

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
vim.o.mousemoveevent = true
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
--
--
-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.cmd "wincmd L" -- move help to the right
    -- vim.cmd "vertical resize vim.o.columns * 0.35" -- set width (columns)
    vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.53))
  end,
})
-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})
local function set_typst_folding()
  vim.opt_local.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
  vim.opt_local.foldlevel = 99
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = set_typst_folding,
})
-- Optional: start with folds open
-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd "normal! zz"
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    vim.lsp.buf.format { bufnr = args.buf }
  end,
})
