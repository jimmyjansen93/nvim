return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'Snikimonkd/telescope-git-conflicts.nvim',
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
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['file_browser'] = {
            theme = 'ivy',
            hidden = { file_browser = true, folder_browser = true },
            hijack_netrw = true,
            layout_config = { height = 0.5 },
          },
        },
      }

      pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'conflicts')

      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sc', '<CMD>Telescope conflicts<CR>', { desc = 'Search [C]onflicts' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader>sf', '<CMD>Telescope find_files hidden=true<CR>', { desc = 'Search ALL Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search Current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = ', Find existing buffers' })
      vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Find File' })
      vim.keymap.set('n', '<leader>fr', '<CMD>Telescope file_browser hidden=true<CR>', { desc = 'File Browser Root' })
      vim.keymap.set('n', '<leader>fb', '<CMD>Telescope file_browser path=%:p:h hidden=true <CR>', { desc = 'File Browser Current' })
      vim.keymap.set('n', '<leader>s\\', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
          previewer = false,
          layout_strategy = 'center',
          layout_config = { width = 0.6, height = 0.6 },
        })
      end, { desc = '/ Fuzzily search in current buffer' })
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
