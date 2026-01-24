return {
  "rmagatti/auto-session",
  -- event = "VeryLazy",
  lazy = false,
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      bypass_save_filetypes = { "Dashboard", "alpha" },
      auto_restore = false, -- Enables/disables auto restoring session on start
      session_lens = {
        picker = "snacks", -- 👈 force Snacks picker
        picker_opts = {
          layout = {
            preset = "dropdown", -- or "ivy", "default", etc.
            preview = true,
          },
          win = {
            title = "Sessions",
          },
        },
        previewer = "summary",

        mappings = {
          delete_session = { "i", "<C-d>" },
          alternate_session = { "i", "<C-s>" },
          copy_session = { "i", "<C-y>" },
        },

        session_control = {
          control_dir = vim.fn.stdpath "data" .. "/auto_session/",
          control_filename = "session_control.json",
        },
      },
    }
  end,
}
