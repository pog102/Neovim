return {
  {
    enabled = false,
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    },
    config = function()
      require("image").setup {
        backend = "sixel", -- or "ueberzug" or "sixel"
        processor = "magick_cli", -- or "magick_rock"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup", -- or "inline"
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          -- neorg = {
          --   enabled = true,
          --   filetypes = { "norg" },
          -- },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        scale_factor = 1.0,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
      default = {
        insert_mode_after_paste = true,
        url_encode_path = true,
        template = "$FILE_PATH",
        use_cursor_in_template = true,

        prompt_for_file_name = true,
        -- show_dir_path_in_prompt = true,

        use_absolute_path = false,
        relative_to_current_file = true,

        embed_image_as_base64 = false,
        max_base64_size = 10,

        drag_and_drop = {
          enabled = true,
          insert_mode = true,
          copy_images = true,
          download_images = true,
        },
      },
      -- add options here
      -- or leave it empty to use the default settings
    },
  },
}
