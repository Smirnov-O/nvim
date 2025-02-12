local map = require("core.utils").map

vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "cv"

map("n", "<localleader>t", "<cmd>Markview toggle<cr>", true)
map("n", "<localleader>T", "<cmd>Markview Toggle<cr>", true)
