return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = false,
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config { virtual_lines = true }
      vim.diagnostic.config { virtual_text = false }

      vim.keymap.set('', '<Leader>cl', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
    end,
  },
}
