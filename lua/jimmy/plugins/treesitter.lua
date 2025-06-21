return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'diff',
          'git_rebase',
          'git_config',
          'gitignore',
          'gomod',
          'http',
          'llvm',
          'make',
          'prisma',
          'sql',
          'ssh_config',
          'tmux',
          'xml',
          'yaml',
          'json',
          'zig',
          'html',
          'lua',
          'markdown',
          'vim',
          'vimdoc',
          'rust',
          'javascript',
          'go',
          'typescript',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      require('nvim-treesitter.configs').setup {
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = { query = '@function.outer', desc = 'Select around function' },
              ['if'] = { query = '@function.inner', desc = 'Select inside function' },
              ['ac'] = { query = '@class.outer', desc = 'Select around class' },
              ['ic'] = { query = '@class.inner', desc = 'Select inside class' },
              ['aa'] = { query = '@parameter.outer', desc = 'Select around argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'Select inside argument' },
              ['ab'] = { query = '@block.outer', desc = 'Select around block' },
              ['ib'] = { query = '@block.inner', desc = 'Select inside block' },
              ['ai'] = { query = '@conditional.outer', desc = 'Select around conditional' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select inside conditional' },
            },
            include_surrounding_whitespace = true,
          },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = { query = '@function.outer', desc = 'Next function start' },
              [']a'] = { query = '@parameter.inner', desc = 'Next argument' },
              [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
            },
            goto_previous_start = {
              ['[m'] = { query = '@function.outer', desc = 'Prev function start' },
              ['[a'] = { query = '@parameter.inner', desc = 'Prev argument' },
              ['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
            },
          },

          swap = {
            enable = false,
            swap_next = { ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap with next argument' } },
            swap_previous = { ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap with previous argument' } },
          },
        },
      }
    end,
  },
}
