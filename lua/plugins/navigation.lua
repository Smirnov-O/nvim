local map = require("core.utils").smap
return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_DiffAutoOpen = 0
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = true,
    keys = {
      { "<leader>a", map("harpoon.mark", "add_file") },
      { "<leader>1", map("harpoon.ui", "toggle_quick_menu") },
      { "<leader>2", map("harpoon.ui", "nav_file", "1") },
      { "<leader>3", map("harpoon.ui", "nav_file", "2") },
      { "<leader>4", map("harpoon.ui", "nav_file", "3") },
      { "<leader>5", map("harpoon.ui", "nav_file", "4") },
    },
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = { { "<leader>e", map("oil", "open") } },
    opts = {
      columns = { "icon" },
      use_default_keymaps = false,
      delete_to_trash = true,
      keymaps = {
        ["?"] = "actions.show_help",
        ["."] = "actions.toggle_hidden",

        ["<CR>"] = "actions.select",
        ["<tab>"] = "actions.select",

        ["<C-v>"] = "actions.select_vsplit",
        ["<C-x>"] = "actions.select_split",
        ["<A-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
        ["<C-c>"] = "actions.close",

        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        [","] = "actions.parent",
        ["<"] = "actions.open_cwd",

        ["\\"] = "actions.cd",
        ["C-\\"] = "actions.tcd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          if
            ({
              [".git"] = {},
              [".vscode"] = {},
              ["dist"] = {},
              ["node_modules"] = {},
              ["__pycache__"] = {},
              ["vendor"] = {},
              ["target"] = {},
            })[name]
          then
            return true
          end
          return false
        end,
      },
    },
  },
}
