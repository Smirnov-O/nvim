---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  keys = { ":" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      enabled = true,
      opts = {},
    },
  },
  config = function()
    local cmp = require "cmp"
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
      sources = { { name = "buffer" }, { name = "luasnip" } },
    })

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "path" }, { name = "cmdline" } },
    })

    cmp.setup {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
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
        { name = "orgmode", group_index = 0, max_item_count = 3 },
        { name = "copilot", group_index = 1, max_item_count = 3 },
        { name = "copilot", group_index = 2, max_item_count = 3 },
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp", max_item_count = 12 },
        { name = "buffer", max_item_count = 4 },
        { name = "luasnip", max_item_count = 3 },
        { name = "path", max_item_count = 2 },
      },
    }
  end,
}
