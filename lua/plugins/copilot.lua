---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
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
        ["."] = false,
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "copilot.lua" },
    branch = "canary",
    cmd = { "CopilotChat" },
    build = "make tiktoken",
    keys = {
      { "<leader>C", ":CopilotChat ", mode = { "n", "v" } },
    },
    opts = {
      mappings = {
        reset = {
          insert = "<C-r>",
          normal = "<C-r>",
        },
        submit_prompt = {
          insert = "<C-CR>",
        },
      },
    },
  },
}
