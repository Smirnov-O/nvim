local u = require "core.utils"

u.aucmd("TextYankPost", {
  group = u.augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

u.aucmd("VimResized", {
  group = u.augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. vim.fn.tabpagenr())
  end,
})

u.aucmd("FileType", {
  group = u.augroup "help",
  pattern = { "help", "man" },
  command = "wincmd L",
})

u.aucmd("FileType", {
  group = u.augroup "quickfix",
  pattern = "qf",
  callback = function()
    u.map("n", "<C-n>", "<cmd>cnext<CR>", true)
    u.map("n", "<C-p>", "<cmd>cprev<CR>", true)
  end,
})

u.aucmd("FileType", {
  group = u.augroup "formatoptions",
  callback = function()
    vim.opt.formatoptions:remove {
      "c", -- autowrap comments using textwidth with leader
      "r", -- don't auto-insert comment leader on enter in insert
      "o", -- don't auto-insert comment leader on o/O in normal
      "n", -- don't recognized numbered lists
      "2", -- don't use the indent of second paragraph line
    }

    vim.opt.formatoptions:append {
      "l", -- long lines not broken in insert mode
      "1", -- don't break a line after a one-letter word
    }
  end,
})
