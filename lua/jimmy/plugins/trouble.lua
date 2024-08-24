return {
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require('trouble').setup {
        use_diagnostic_signs = true,
        auto_close = false,
      }

      vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', { noremap = true, silent = true, desc = 'Document Diagnostics' })
      vim.keymap.set('n', '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', { noremap = true, silent = true, desc = 'Workspace Diagnostics' })
      vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { noremap = true, silent = true, desc = 'Location List' })
      vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { noremap = true, silent = true, desc = 'Quickfix List' })

      vim.keymap.set(
        'n',
        '[q',
        '<cmd>lua require("trouble").previous { skip_groups = true, jump = true }<cr>',
        { noremap = true, silent = true, desc = 'Previous trouble/quickfix item' }
      )

      vim.keymap.set(
        'n',
        ']q',
        '<cmd>lua require("trouble").next { skip_groups = true, jump = true }<cr>',
        { noremap = true, silent = true, desc = 'Next trouble/quickfix item' }
      )

      vim.keymap.set('n', 'gR', function()
        require('trouble').toggle 'lsp_references'
      end)

      local function show_diagnostics()
        require('telescope.builtin').diagnostics {
          bufnr = 0,
          winblend = 10,
          layout_config = {
            width = 0.9,
            height = 0.7,
            prompt_position = 'top',
          },
        }
      end

      -- New keymap for floating diagnostics
      vim.keymap.set('n', '<leader>xf', show_diagnostics, { noremap = true, silent = true, desc = 'Show Floating Diagnostics' })
    end,
  },
}
