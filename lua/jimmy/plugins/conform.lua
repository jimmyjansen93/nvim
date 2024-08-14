return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', { 'gofumpt', 'gofmt' }, 'golines', 'staticcheck' },
        javascript = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        javascriptreact = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        typescript = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        typescriptreact = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
      },
    },
  },
}
