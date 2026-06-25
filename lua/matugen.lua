local M = {}

function M.setup()
	require("base16-colorscheme").setup({
		base00 = "NONE",
		base01 = "#1e2020",
		base02 = "#282a2b",
		base03 = "#8a9293",
		base04 = "#c0c8c9",
		base05 = "#e2e2e2",
		base06 = "#e2e2e2",
		base07 = "#e2e2e2",
		base08 = "#ffb4ab",
		base09 = "#d1c0e4",
		base0A = "#b9cacc",
		base0B = "#a4ced4",
		base0C = "#d1c0e4",
		base0D = "#a4ced4",
		base0E = "#b9cacc",
		base0F = "#93000a",
	})

	local hi = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	hi("TelescopeNormal", { fg = "#e2e2e2", bg = "#121414" })
	hi("TelescopeBorder", { fg = "#8a9293", bg = "#121414" })
	hi("TelescopePromptNormal", { fg = "#e2e2e2", bg = "#121414" })
	hi("TelescopePromptBorder", { fg = "#8a9293", bg = "#121414" })
	hi("TelescopePromptPrefix", { fg = "#a4ced4", bg = "#121414" })
	hi(
		"TelescopePromptCounter",
		{ fg = "#c0c8c9", bg = "#121414" }
	)
	hi("TelescopePromptTitle", { fg = "#121414", bg = "#a4ced4" })
	hi("TelescopePreviewTitle", { fg = "#121414", bg = "#b9cacc" })
	hi("TelescopeResultsTitle", { fg = "#121414", bg = "#d1c0e4" })
	hi(
		"TelescopeSelection",
		{ fg = "#e2e2e2", bg = "#282a2b" }
	)
	hi(
		"TelescopeSelectionCaret",
		{ fg = "#a4ced4", bg = "#282a2b" }
	)
	hi("TelescopeMatching", { fg = "#a4ced4", bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
	"sigusr1",
	vim.schedule_wrap(function()
		package.loaded["matugen"] = nil
		require("matugen").setup()
	end)
)

return M
