require("nvchad.configs.lspconfig").defaults()

local servers = {
  cssls = {},
  tailwindcss = {},
  html = {},
  jsonls = {},
  ts_ls = {},
  eslint = {},
  nixd = {},
  docker_compose_language_service = {},
  dockerls = {},
  clangd = {},
  -- ccls = {},
  cmake = {},
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          diagnosticMode = "workspace",
          typeCheckingMode = "standard",
        },
      },
    },
  },
  marksman = {},
  texlab = {},
  ocamllsp = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- read :h vim.lsp.config for changing options of lsp servers
