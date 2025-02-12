local enabled = true

---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    enabled = enabled,
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = {
        enabled = false,
        auto_refresh = true,
        keymap = { refresh = "<C-r>" },
        layout = {
          position = "right",
          ratio = 0.3,
        },
      },
      filetypes = {
        yaml = true,
        TelescopePrompt = false,
        org = false,
        ["."] = false,
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "copilot.lua" },
    enabled = enabled,
    cmd = { "CopilotChat" },
    build = "make tiktoken",
    keys = {
      { "<leader>C", ":CopilotChat ", mode = { "n", "v" } },
    },
    ---@module "CopilotChat"
    ---@type CopilotChat.config
    opts = {
      auto_insert_mode = true,
      mappings = {
        reset = {
          insert = "<C-r>",
          normal = "<C-r>",
        },
        submit_prompt = {
          insert = "<C-CR>",
        },
        show_help = { normal = "?" },
      },
    },
  },
  {
    "nvim-cmp",
    enabled = enabled,
    dependencies = {
      { "zbirenbaum/copilot-cmp", config = true },
      "copilot.lua",
    },
    ---@module "cmp"
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 2,
        max_item_count = 3,
      })
    end,
  },
}
