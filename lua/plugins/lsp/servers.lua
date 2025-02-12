return {
  clangd = {},
  eslint = {},
  html = {},
  gleam = {},
  templ = {},
  bashls = {},
  gopls = {
    settings = {
      gopls = {
        linksInHover = false,
        staticcheck = true,
        gofumpt = true,
        analyses = {
          unusedparams = true,
          unreachable = true,
          unusedwrite = true,
          useany = true,
          shadow = true,
          nilness = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = false,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        codelenses = {
          generate = true,
          gc_details = false,
          test = true,
          tidy = true,
          run_govulncheck = true,
          upgrade_dependency = true,
        },
      },
    },
  },
  golangci_lint_ls = {
    init_options = {
      command = {
        "golangci-lint",
        "run",
        "--fast",
        "--out-format",
        "json",
        "--issues-exit-code=1",
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        format = { enable = false },
        completion = { callSnippet = "Replace" },
        telemetry = { enable = false },
        hint = {
          enable = true,
          arrayIndex = "Disable",
          await = true,
          paramName = "Disable",
          paramType = false,
          semicolon = "Disable",
          setType = true,
        },
      },
    },
  },
  markdown_oxide = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
}
