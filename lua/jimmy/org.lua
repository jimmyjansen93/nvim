return {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      'nvim-telescope/telescope.nvim',

      {
        'danilshvalov/org-modern.nvim',
        config = function()
          local Menu = require 'org-modern.menu'
          require('orgmode').setup {
            ui = {
              menu = {
                handler = function(data)
                  Menu:new({
                    window = {
                      margin = { 1, 0, 1, 0 },
                      padding = { 0, 1, 0, 1 },
                      title_pos = 'center',
                      border = 'single',
                      zindex = 1000,
                    },
                    icons = {
                      separator = '➜',
                    },
                  }):open(data)
                end,
              },
            },
          }
        end,
      },

      {
        'michaelb/sniprun',
        branch = 'master',
        build = 'sh install.sh',
        config = function()
          require('sniprun').setup {}
        end,
      },
      {
        'jimmyjansen93/telescope-orgmode.nvim',
        config = function()
          require('telescope').load_extension 'orgmode'
          vim.keymap.set('n', '<leader>oR', require('telescope').extensions.orgmode.refile_heading, { desc = '[O]rg [R]efile' })
          vim.keymap.set('n', '<leader>oH', require('telescope').extensions.orgmode.search_headings, { desc = '[O]rg [H]eadings' })
        end,
      },
      { 'dhruvasagar/vim-table-mode' },
      { 'nvim-orgmode/org-bullets.nvim', opts = {} },
      { 'lukas-reineke/headlines.nvim', opts = {} },
    },
    event = 'BufEnter',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        ensure_installed = { 'org' },
      }

      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
        org_startup_folded = 'content',
        org_log_into_drawer = 'LOGBOOK',
        calendar_week_start_day = 1,
        org_log_done = 'note',
        org_agenda_skip_scheduled_if_done = true,
        org_tags_column = 120,
        mappings = {
          org_return_uses_meta_return = true,
          org = {
            org_toggle_checkbox = '<CR>',
          },
        },
        org_todo_keywords = {
          'BACKLOG(b)',
          'PLANNED(p)',
          'TODO(t)',
          'NEXT(n)',
          'ACTIVE(a)',
          'REVIEW(v)',
          'WAIT(w)',
          'HOLD(h)',
          '|',
          'DONE(d)',
          'CANCELED(k)',
        },
        win_split_mode = { 'float', 0.9 },
        org_capture_templates = {
          t = {
            description = 'Todo',
            template = '* TODO %?\n %u',
            target = '~/org/todo.org',
            dateTree = { reversed = true },
            headline = 'Work',
          },
          T = {
            description = 'Todo',
            template = '* TODO %?\n %u',
            target = '~/org/todo.org',
            dateTree = { reversed = true },
            headline = 'Private',
          },
          j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            dateTree = { tree_type = 'day' },
            target = '~/org/journal.org',
            headline = 'Work',
          },
          J = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            dateTree = { tree_type = 'day' },
            target = '~/org/journal.org',
            headline = 'Private',
          },
          m = {
            description = 'Meeting',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            dateTree = { tree_type = 'day' },
            target = '~/org/journal.org',
            headline = 'Work',
          },
        },
      }

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>of', function()
        builtin.find_files { cwd = '~/org' }
      end, { desc = '[O]rg [F]iles' })
    end,
    keys = {
      { '<leader>o', '', desc = 'Org mode' },
    },
  },
}
