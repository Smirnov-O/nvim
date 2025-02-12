---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      { "nvim-treesitter/nvim-treesitter-context", config = true },
    },
    build = function()
      pcall(vim.cmd.TSUpdate)
    end,
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      auto_install = true,
      ensure_installed = {
        "sql",
        "markdown",
        "markdown_inline",
        "vim",
        "query",
      },
      ignore_install = { "org" },
      indent = { enable = true, disable = { "python" } },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      autopairs = { enable = true },
      endwise = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
    init = function()
      local get_option = vim.filetype.get_option

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.filetype.get_option = function(filetype, option)
        -- stylua: ignore
        return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
