local map = require("core.utils").map

-- options
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

-- mapping
map("n", "<localleader>f", "<cmd>GoIfErr<cr>", true)
map("n", "<localleader>c", "<cmd>GoCmt<cr>", true)

map("n", "<localleader>t", "<cmd>GoTestAdd<cr>", true)
map("n", "<localleader>a", "<cmd>GoTestsAll<cr>", true)
map("n", "<localleader>e", "<cmd>GoTestsExp<cr>", true)

map("n", "<localleader>s", require("scratch.gotest_switcher").switch, true)
