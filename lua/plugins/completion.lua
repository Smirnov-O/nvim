---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    { "hrsh7th/cmp-cmdline", keys = { ":" } },
    { "kirasok/cmp-hledger", ft = "ledger" },
  },
  config = function(_, opts)
    local cmp = require "cmp"

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
      sources = { { name = "buffer" }, { name = "luasnip" } },
    })

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "path" }, { name = "cmdline" } },
    })

    cmp.setup(opts)
  end,

  opts = function()
    local cmp = require "cmp"

    ---@type cmp.Config
    ---@diagnostic disable-next-line: missing-fields
    return {
      --- snippets are set up in [luasnip.lua]
      window = {},
      ---@diagnostic disable-next-line: missing-fields
      view = { entries = { follow_cursor = true } },
      experimental = { ghost_text = true },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = function(_, vim_item)
          vim_item.kind = ({
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
            Copilot = "",
          })[vim_item.kind]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        },
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
      sources = cmp.config.sources {
        { name = "hledger", group_index = 0 },
        { name = "buffer", group_index = 3, max_item_count = 4 },
        { name = "path", group_index = 4, max_item_count = 2 },
      },
    }
  end,
}
