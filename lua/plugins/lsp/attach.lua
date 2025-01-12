local u = require "core.utils"

u.aucmd("LspAttach", {
  group = u.augroup "lsp",
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      error "couldn't get an lsp server"
    end

    if client.supports_method "textDocument/codeLens" then
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end

    u.map("n", "<leader>lf", function()
      vim.lsp.buf.format { async = true }
    end, bufnr)
    u.map("n", "]d", function()
      pcall(vim.diagnostic.goto_next, { float = false })
    end, bufnr)
    u.map("n", "[d", function()
      pcall(vim.diagnostic.goto_prev, { float = false })
    end, bufnr)

    u.map("n", "K", vim.lsp.buf.hover, bufnr)
    u.map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufnr)
    u.map("n", "gr", "<cmd>Telescope lsp_references<cr>", bufnr)
    u.map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", bufnr)
    u.map("n", "gl", vim.diagnostic.open_float, bufnr)
    u.map("n", "<leader>la", vim.lsp.buf.code_action, bufnr)
    u.map("n", "<leader>lr", vim.lsp.buf.rename, bufnr)
    u.map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", bufnr)
    u.map("n", "<leader>ll", vim.lsp.codelens.run, bufnr)
    u.map("n", "<leader>li", function()
      if vim.lsp.inlay_hint.is_enabled { bufnr = bufnr } then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        vim.print "Inlay hints disabled"
      else
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.print "Inlay hints enabled"
      end
    end, bufnr)
  end,
})
