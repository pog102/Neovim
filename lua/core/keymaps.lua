local opts = { noremap = true, silent = true }
-- vim.keymap.set("t", "<C-/>", function()
--   -- require("snacks").terminal.toggle()
--   --              require("floaterm.api").cycle_term_bufs "prev"
-- end, { noremap = true, silent = true })
--
-- Window navigation
-- Keybinding: <A-d> to open Snacks picker with recent files
-- keys = { "<c-/>", mode = { "n", "t" }, "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },

if vim.fn.has "win32" == 1 then
  vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal (Snacks)" })
else
  vim.keymap.set({ "n", "t" }, "<C-/>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal (Snacks)" })
end
vim.keymap.set("n", "<A-d>", function()
  require("snacks.picker").recent()
end, { desc = "Snacks: Find Recent Files" })
vim.keymap.set("n", "<C-s>", "<cmd>vsplit<CR>", opts)

vim.keymap.set("n", "<A-Left>", "<cmd>wincmd W<CR>", opts)
vim.keymap.set("n", "<A-Right>", "<cmd>wincmd w<CR>", opts)
vim.keymap.set("n", "<A-Up>", "<cmd>wincmd k<CR>", opts)
vim.keymap.set("n", "<A-Down>", "<cmd>wincmd j<CR>", opts)
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_create_user_command("Messages", function()
  require("snacks").notifier.show_history()
end, {})

-- Window resizing
vim.keymap.set("n", "<A-S-Left>", "<cmd>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<A-S-Right>", "<cmd>vertical resize +2<CR>", opts)
vim.keymap.set("n", "<A-S-Up>", "<cmd>resize +2<CR>", opts)
vim.keymap.set("n", "<A-S-Down>", "<cmd>resize -2<CR>", opts)
for i = 1, 9 do
  vim.api.nvim_set_keymap("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

vim.g.pleader = " "
vim.g.mapleader = " "
vim.g.plocalleader = " "
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
-- vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- the how it be paste
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- leader d delete wont remember as yanked/clipboard when delete pasting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- ctrl c as escape cuz Im lazy to reach up to the esc key
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })
vim.keymap.set("n", "<S-l>", ":Lazy<CR>", { desc = "Open Lazy", silent = true })
-- format without prettier using the built in
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-f>", "/")
-- Unmaps Q in normal mode
vim.keymap.set("n", "Q", "<nop>")

--Stars new tmux session from in here

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- Replace the word cursor is on globally
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
-- { desc = "Replace word cursor is on globally" })

-- Executes shell command from in here king file executable

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split nagement
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "ke splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand "%:~" -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover { border = "rounded" }
end)
-- Toggle LSP diagnostics visibility
-- local isLspDiagnosticsVisible = true
-- vim.keymap.set("n", "<leader>lx", function()
--     isLspDiagnosticsVisible = not isLspDiagnosticsVisible
--     vim.diagnostic.config({
--         virtual_text = isLspDiagnosticsVisible,
--         underline = isLspDiagnosticsVisible
--     })
-- end, { desc = "Toggle LSP diagnostics" })
