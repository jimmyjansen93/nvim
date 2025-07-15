return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
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
      local project_files = function()
        local is_inside_work_tree = {}
        local opts = { 'rg', '--files', '--glob', '!**/.git/*' }

        local cwd = vim.fn.getcwd()
        if is_inside_work_tree[cwd] == nil then
          vim.fn.system 'git rev-parse --is-inside-work-tree'
          is_inside_work_tree[cwd] = vim.v.shell_error == 0
        end

        if is_inside_work_tree[cwd] then
          require('telescope.builtin').git_files(opts)
        else
          require('telescope.builtin').find_files(opts)
        end
      end

      local previewers = require 'telescope.previewers'
      local Job = require 'plenary.job'
      local new_maker = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job:new({
          command = 'file',
          args = { '--mime-type', '-b', filepath },
          on_exit = function(j)
            local mime_type = vim.split(j:result()[1], '/')[1]
            if mime_type == 'text' then
              previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
              vim.schedule(function()
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
              end)
            end
          end,
        }):sync()
      end

      local actions = require 'telescope.actions'
      require('telescope').setup {
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
              },
            },
          },
          find_files = {
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
          },
          lsp_document_symbols = {
            layout_strategy = 'horizontal',
            layout_config = {
              width = 0.99,
              preview_width = 0.7,
            },
          },
        },
        defaults = {
          buffer_previewer_maker = new_maker,
          path_display = { 'filename_first' },
          mappings = {
            i = {
              ['<C-u>'] = false,
            },
          },
          layout_strategy = 'flex',
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              width = 0.99,
              height = 0.99,
            },
            vertical = {
              prompt_position = 'top',
              width = 0.99,
              height = 0.99,
            },
          },
          preview = true,
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--trim',
          },
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
      vim.keymap.set('n', '<leader> ', project_files, { desc = 'Find File' })

      local webicon = require 'nvim-web-devicons'
      local docIcon = webicon.get_icon('DevIconReadme', 'lua')
      local workIcon = webicon.get_icon('DevIconLua', 'lua')
      require('which-key').add {
        { '<leader>;', builtin.lsp_document_symbols, desc = 'Document Symbols', icon = docIcon },
        { '<leader>s;', builtin.lsp_dynamic_workspace_symbols, desc = 'Workspace Symbols', icon = workIcon },
      }

      vim.keymap.set('n', '<leader>/', function()
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
