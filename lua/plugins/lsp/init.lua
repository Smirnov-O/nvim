---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    "b0o/schemastore.nvim",
    { import = "plugins.lsp.lazydev" },
    { import = "plugins.lsp.null-ls" },
    {
      "j-hui/fidget.nvim",
      dependencies = { "nvim-lspconfig" },
      opts = {
        progress = {
          display = {
            render_limit = 2,
            done_ttl = 2,
          },
        },
      },
    },
    {
      "nvim-cmp",
      ---@module "cmp"
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, {
          name = "nvim_lsp",
          group_index = 1,
          max_item_count = 12,
        })
      end,
    },
    {
      "RRethy/vim-illuminate",
      dependencies = { "nvim-lspconfig" },
      opts = {
        providers = { "lsp", "treesitter" },
        filetypes_denylist = {
          "NvimTree",
          "packer",
          "NeogitStatus",
          "TelescopePrompt",
        },
      },
      config = function(_, opts)
        require("illuminate").configure(opts)
      end,
    },
  },
  config = function()
    for name, conf in pairs(require "plugins.lsp.servers") do
      require "plugins.lsp.attach"
      require("lspconfig")[name].setup(vim.tbl_extend("force", {
        flags = { debounce_text_changes = 150 },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }, conf))
    end
  end,
}
