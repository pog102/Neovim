return {

  "zbirenbaum/copilot.lua",
  -- event = "InsertEnter",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = { "samiulsami/copilot-eldritch.nvim" },

  config = function()
    require("copilot").setup {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-Enter>", -- Alt-Eter to accept suggestion
          next = "<M-]>", -- next suggestion
          prev = "<M-[>", -- previous suggestion
        },
      },
    }
    require("copilot-eldritch").setup()
  end,
}
