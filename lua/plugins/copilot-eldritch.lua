return {
  -- enabled = false,
  "zbirenbaum/copilot.lua",
  -- event = "InsertEnter",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = { "samiulsami/copilot-eldritch.nvim" },

  config = function()
    require("copilot").setup {
      disable_limit_reached_message = true, -- Set to `true` to suppress completion limit reached popup
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<S-Enter>", -- Alt-Eter to accept suggestion
          next = "<M-]>", -- next suggestion
          prev = "<M-[>", -- previous suggestion
        },
      },
    }
    require("copilot-eldritch").setup()
  end,
}
