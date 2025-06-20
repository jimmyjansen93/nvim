return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          sorting_strategy = 'ascending',
          layout_config = {
            vertical = {
              prompt_position = 'top',
              height = 0.5,
              width = 0.5,
            },
          },
          preview = false,
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      -- pcall(require('telescope').load_extension, 'conflicts')

      local builtin = require 'telescope.builtin'

      -- vim.keymap.set('n', '<leader>sc', '<CMD>Telescope conflicts<CR>', { desc = 'Search Conflicts' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader>sf', '<CMD>Telescope find_files hidden=true<CR>', { desc = 'Search All Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search Current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files' })

      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Find File' })

      vim.keymap.set('n', '<leader>;', builtin.lsp_document_symbols, { desc = 'Document Symbols' })
      vim.keymap.set('n', '<leader>s;', builtin.lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim files' })
    end,
  },
}
