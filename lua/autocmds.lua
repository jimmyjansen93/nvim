vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('jj-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit help with q',
  pattern = 'help,qf,netrw',
  group = vim.api.nvim_create_augroup('jj-help-utils', { clear = true }),
  callback = function()
    vim.keymap.set('n', 'q', '<C-w>c', { buffer = true, desc = 'quit' })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Stop commenting next line',
  group = vim.api.nvim_create_augroup('jj-comments', { clear = true }),
  command = [[set formatoptions -=cro]],
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Disable diagnostic in node_modules',
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
})

local format_sync_grp = vim.api.nvim_create_augroup('goimports', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('jimmy-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
    map('gr', require('telescope.builtin').lsp_references, 'Goto References')
    map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
    map('<leader>cd', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
    map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    map('<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    local capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
      root_markers = { '.git' },
    }

    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    vim.lsp.config('*', capabilities)

    local client = vim.lsp.get_clients { buffer = event.data.client_id }
    if client[1] and client[1].server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
