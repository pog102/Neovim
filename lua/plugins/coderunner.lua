return {
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
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
      },
    }
  end,
}
