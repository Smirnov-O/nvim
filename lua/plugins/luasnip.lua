---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "nvim-cmp",
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        opts.snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        }
        table.insert(opts.sources, {
          name = "luasnip",
          group_index = 2,
          max_item_count = 3,
        })
      end,
    },
  },
  build = "make install_jsregexp",
  keys = {
    {
      "<C-l>",
      function()
        local ls = require "luasnip"
        if ls.choice_active() then
          ls.change_choice(1)
        elseif ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
      mode = { "s", "i" },
    },
  },
  config = function()
    local ls = require "luasnip"
    local types = require "luasnip.util.types"

    ls.config.set_config {
      ext_opts = {
        [types.choiceNode] = {
          passive = {
            virt_text = { { "●", "Operator" } },
            hl_group = "LuaSnipChoiceNode",
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "●", "Type" } },
            hl_group = "LuaSnipInsertNode",
          },
        },
      },
    }

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
