local orgdir = "~/org/"
local function orgpath(p, not_file)
  return orgdir .. p .. (not not_file and ".org" or "")
end

local function action(act, opts)
  return function()
    return require("orgmode").action(act, opts or {})
  end
end

local function find_orgfiles()
  require("telescope.builtin").find_files {
    cwd = orgdir,
    find_command = {
      "fd",
      "--type",
      "f",
      "--exclude",
      "finance", -- idk why i store my ledger files in the same repo
      "--exclude",
      "*.org_archive",
      ".org",
    },
  }
end

---@type LazySpec
return {
  "nvim-orgmode/orgmode",
  ft = "org",
  keys = {
    "<leader>o",
    { "<leader>oo", ("<cmd>e " .. orgpath "refile" .. "<CR>") },
    { "<leader>so", find_orgfiles },
    { "<leader>oc", action "capture.prompt" },
    { "<leader>oa", action "agenda.prompt" },
  },
  dependencies = {
    { "akinsho/org-bullets.nvim", config = true },
    {
      "nvim-cmp",
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, {
          name = "orgmode",
          group_index = 0,
        })
      end,
    },
  },
  ---@module "orgmode"
  ---@type OrgConfigOpts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    org_default_notes_file = orgpath "refile",
    org_agenda_files = orgpath("**/*", true),
    -- stylua: ignore
    org_todo_keywords = { "TODO(t)", "INB(i)", "DOING(I)", "SCHEDULED(s)", "|", "DONE(d)", "CANCEL(c)",},
    org_hide_emphasis_markers = true,
    org_startup_indented = true,
    org_startup_folded = "content", -- "showeverything"
    mappings = {
      prefix = "<leader>o",
      org = {
        org_open_at_point = "<CR>",
        org_return = nil,
        org_export = nil,
      },
      global = {
        org_agenda = nil,
        org_capture = nil,
      },
    },
    org_capture_templates = {
      t = {
        description = "Task",
        template = "* INB %?",
        target = orgpath "todo",
      },
      i = { description = "Inbox", template = "* INB %?" },
      w = {
        description = "New vocab",
        template = "* %?",
        headline = "new vocab",
      },
    },
  },
}
