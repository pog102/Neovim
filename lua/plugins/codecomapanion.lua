return {
  "olimorris/codecompanion.nvim",
  -- enabled = false,
  version = "^18.0.0",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "github/copilot.vim",
    -- "ravitemer/mcphub.nvim",
  },
  config = function()
    require("codecompanion").setup {
      --   adapters = {
      --     http = {
      --       llama_cpp = {
      --         name = "llama.cpp",
      --         url = "http://127.0.0.1:8080",
      --         schema = {
      --           model = {
      --             default = "local-model",
      --           },
      --           temperature = {
      --             default = 0.2,
      --           },
      --           max_tokens = {
      --             default = 1024,
      --           },
      --         },
      --       },
      --     },
      --   },
      --   ignore_warnings = true,
      display = {
        chat = {
          window = {
            position = "right",
            width = 0.35,
          },
        },
      },
      --   strategies = {
      --     chat = {
      --       -- adapter = "gemini",
      --       -- adapter = "copilot",
      --       adapter = "llama_cpp",
      --     },
      --     inline = {
      --       -- adapter = "gemini",
      --       -- adapter = "copilot",
      --       adapter = "llama_cpp",
      --     },
      --   },
      adapters = {
        http = {
          ["llama.cpp"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "llama.cpp",
              env = {
                url = "http://127.0.0.1:8080", -- replace with your llama.cpp instance
                api_key = "TERM",
                chat_url = "/v1/chat/completions",
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning_content then
                    -- data.output.reasoning = { content = extra.reasoning_content }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "llama.cpp",
        },
        inline = {
          adapter = "llama.cpp",
        },
      },
    }
    -- vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
    -- Remap Copilot accept mapping from Tab to Caps Lock
    -- vim.api.nvim_set_keymap("n", "<CapsLock>", "<Plug>(copilot-accept)", { noremap = false, silent = true })
  end,
}
