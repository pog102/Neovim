return {
  enable = true,
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup {
      mode = "term",
      focus = false,
      -- startinsert = true,
      term = {
        position = "vert",
        -- size = 0.4,
        size = vim.o.columns * 0.40,
      },
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        svelte = "bun dev",
        typescript = "deno run",
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt &&",
          "./$fileNameWithoutExt",
        },
        -- rust = {
        --   "cd $dir &&",
        --   "rustc $fileName &&",
        --   "$dir/$fileNameWithoutExt",
        -- },
        -- c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
      },
    }
    -- Auto-close ONLY the terminal buffer when the process exits
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*",
      callback = function(ev)
        -- Use vim.schedule to avoid modifying buffers mid-event-stream
        vim.schedule(function()
          -- Force delete the specific terminal buffer that just closed
          if vim.api.nvim_buf_is_valid(ev.buf) then
            vim.api.nvim_buf_delete(ev.buf, { force = true })
          end
        end)
      end,
    })
  end,
}
