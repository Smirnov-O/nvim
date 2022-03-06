require("project_nvim").setup {
  manual_mode = false,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git", "Makefile", "package.json", "go.mod" },
  show_hidden = false,
  silent_chdir = true,
}