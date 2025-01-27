return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup { '*' }
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
        go = { 'goimports', 'gofumpt', 'golines', 'staticcheck' },
        javascript = { 'eslint', 'prettier' },
        typescript = { 'eslint', 'prettier' },
      },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():add()
      end, { desc = 'Harpoon Add List' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon Toggle menu' })

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon Next' })

      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon Next' })
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
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
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('undotree').setup {
        float_diff = true, -- using float window previews diff, set this `true` will disable layout option
        layout = 'left_bottom', -- "left_bottom", "left_left_bottom"
        position = 'left', -- "right", "bottom"
        ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
        window = {
          winblend = 10,
        },
        keymaps = {
          ['j'] = 'move_next',
          ['k'] = 'move_prev',
          ['gj'] = 'move2parent',
          ['J'] = 'move_change_next',
          ['K'] = 'move_change_prev',
          ['<cr>'] = 'action_enter',
          ['p'] = 'enter_diffbuf',
          ['q'] = 'quit',
        },
      }

      vim.keymap.set('n', '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", { desc = 'Undotree' })
    end,
  },
}
