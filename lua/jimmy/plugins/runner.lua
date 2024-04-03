return {
  {
    'catgoose/do-the-needful.nvim',
    event = 'BufReadPre',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('do-the-needful').setup {
        config_order = { 'global' },
        global_tokens = {
          ['${cwd}'] = vim.fn.getcwd,
          ['${do-the-needful}'] = 'please',
          ['${projectname}'] = function()
            return vim.fn.system 'basename $(git rev-parse --show-toplevel)'
          end,
        },
        ask_functions = {
          get_cwd = function()
            return vim.fn.getcwd()
          end,
          current_file = function()
            return vim.fn.expand '%'
          end,
        },
      }
      vim.keymap.set('n', '<leader>;', '<CMD>lua require("do-the-needful").please()<CR>', { desc = 'Tmux run' })
      vim.keymap.set('n', '<leader>qr', '<CMD>lua require("do-the-needful").edit_config("global")<CR><cr>', { desc = 'Edit Tmux run' })
    end,
  },

  {
    'nvimtools/hydra.nvim',
    config = function()
      local hydra = require 'hydra'

      hydra.setup {}
    end,
  },

  {
    'stevearc/overseer.nvim',
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
