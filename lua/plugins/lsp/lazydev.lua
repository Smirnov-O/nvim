---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  dependencies = {
    "nvim-lspconfig",
    {
      "nvim-cmp",
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, 1, {
          name = "lazydev",
          group_index = 0,
        })
      end,
    },
  },
  ---@module "lazydev"
  ---@type lazydev.Config
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "mini.test", words = { "MiniTest" } },
      { path = "mini.ai", words = { "MiniAI" } },
      "lazy.nvim",
    },
  },
}
