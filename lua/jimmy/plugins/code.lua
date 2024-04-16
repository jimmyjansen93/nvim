return {
  { 'numToStr/Comment.nvim', lazy = false, opts = {} },
  { 'gpanders/editorconfig.nvim' },
  { 'kylechui/nvim-surround', opts = {}, event = 'VeryLazy' },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup { use_default_keymaps = false, notify = false }

      vim.keymap.set('n', '<leader>cj', require('treesj').toggle, { desc = 'Toogle join' })
    end,
  },

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
      vim.keymap.set('n', '<leader>xL', '<cmd>TroubleToggle loclist<cr>', { noremap = true, silent = true, desc = 'Location List' })
      vim.keymap.set('n', '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', { noremap = true, silent = true, desc = 'Quickfix List' })
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
    end,
  },

  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup { signs = true }

      vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { noremap = true, silent = true, desc = 'Todo Trouble' })
      vim.keymap.set('n', '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', { noremap = true, silent = true, desc = 'Todo/Fix/Fixme Trouble' })
      vim.keymap.set('n', '<leader>xs', '<cmd>TodoTelescope<cr>', { noremap = true, silent = true, desc = 'Todo Telescope' })
      vim.keymap.set('n', '<leader>xS', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', { noremap = true, silent = true, desc = 'Todo/Fix/Fixme' })
    end,
  },

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
        javascript = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        javascriptreact = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        typescript = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
        typescriptreact = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
      },
    },
  },
}
