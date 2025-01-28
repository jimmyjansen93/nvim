return {
  {
    'ahmedkhalf/project.nvim',
    enabled = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('project_nvim').setup {
        manual_mode = false,
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', 'Makefile', 'package.json', '.cargo' },
        scope_chdir = 'global', -- global, tab, win
        datapath = vim.fn.stdpath 'data',
      }

      local telescope = require 'telescope'
      telescope.load_extension 'projects'
      vim.keymap.set('n', '<Leader>pp', '<cmd>Telescope projects<CR>', { desc = 'Open Projects' })
    end,
    -- keys = {
    --   { '<leader>pp', require('telescope').extensions.projects {}, desc = 'Open Projects' },
    -- },
  },
}
