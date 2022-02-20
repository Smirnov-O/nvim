local on_attach = require "lsp.attach"
local diagnostic = require "lsp.diagnostic"
local M = {}

function M.setup()
  vim.diagnostic.config(diagnostic)

  require("nvim-lsp-installer").on_server_ready(function(server)
    require("lsp.null").setup()
    local opts = {
      on_attach = on_attach,
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }

    -- set signs
    for _, sign in ipairs(diagnostic.signs.active) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- set server config him exists
    local ok, server_opts = pcall(require, "lsp.providers." .. server.name)
    if ok then
      opts = vim.tbl_deep_extend("force", opts, server_opts or {})
    end

    require("lspconfig").nimls.setup(opts)
    server:setup(opts)

    vim.cmd [[ do User LspAttachBuffers ]]
  end)
end

return M
