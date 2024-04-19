return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      {
        'zbirenbaum/copilot.lua',
        opts = {
          panel = { enabled = false },
          suggestion = { enabled = false },
        },
      },

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      {
        'David-Kunz/cmp-npm',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = 'json',
        config = function()
          require('cmp-npm').setup {}
        end,
      },

      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'

      cmp.setup {
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol',
            maxwidth = function()
              return math.floor(0.4 * vim.o.columns)
            end,
            ellipsis_char = '...',
            symbol_map = { Copilot = '' },
          },
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<C-m>'] = cmp.mapping.complete {},
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'copilot' },
          { name = 'path' },
          { name = 'npm', keyword_length = 4 },
        },
      }
    end,
  },

  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' },
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   opts = {
  --     window = { layout = 'float', height = 0.9, width = 0.9 },
  --     prompts = {
  --       Explain = 'Explain how it works.',
  --       Review = 'Review the following code and provide concise suggestions.',
  --       Tests = 'Briefly explain how the selected code works, then generate unit tests.',
  --       Refactor = 'Refactor the code to improve clarity and readability.',
  --     },
  --   },
  -- },
  -- keys = {
  --   { '<leader>ccb', '<CMD>CopilotChatBuffer<cr>', desc = 'CopilotChat - Buffer' },
  --   { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
  --   { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
  --   {
  --     '<leader>ccT',
  --     '<cmd>CopilotChatVsplitToggle<cr>',
  --     desc = 'CopilotChat - Toggle Vsplit', -- Toggle vertical split
  --   },
  --   {
  --     '<leader>ccv',
  --     ':CopilotChatVisual',
  --     mode = 'x',
  --     desc = 'CopilotChat - Open in vertical split',
  --   },
  --   {
  --     '<leader>ccc',
  --     ':CopilotChatInPlace<cr>',
  --     mode = { 'n', 'x' },
  --     desc = 'CopilotChat - Run in-place code',
  --   },
  --   {
  --     '<leader>ccf',
  --     '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
  --     desc = 'CopilotChat - Fix diagnostic',
  --   },
  -- },
}
