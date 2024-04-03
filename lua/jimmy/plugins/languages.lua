return {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  { 'dmmulroy/tsc.nvim', ft = { 'typescript', 'typescriptreact' }, dependencies = { 'rcarriga/nvim-notify' }, opts = {} },

  { 'dmmulroy/ts-error-translator.nvim', ft = { 'typescript', 'typescriptreact' } },

  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },

  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim' },
    config = function()
      require('rest-nvim').setup {
        result = {
          behavior = {
            statistics = {
              enable = true,
              --- https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { 'total_time', title = 'Time taken:' },
                { 'size_download_t', title = 'Download size:' },
              },
            },
          },
        },
        highlight = {
          enable = true,
          timeout = 750,
        },
        keys = {
          {
            '<leader>rq',
            '<cmd>Rest run<cr>',
            'Run request under the cursor',
          },
          {
            '<leader>rl',
            '<cmd>Rest run last<cr>',
            'Re-run latest request',
          },
        },
      }
    end,
  },

  {
    'andrewferrier/debugprint.nvim',
    version = '*',
    config = function()
      require('debugprint').setup { print_tag = 'DEBUG' }
      local debugprint = require 'debugprint'

      vim.keymap.set('n', '<Leader>dp', function()
        return debugprint.debugprint()
      end, {
        expr = true,
        desc = 'Debug Print',
      })
      vim.keymap.set('n', '<Leader>dP', function()
        return debugprint.debugprint { above = true }
      end, {
        expr = true,
        desc = 'Debug Print Above',
      })
      vim.keymap.set('n', '<Leader>dv', function()
        return debugprint.debugprint { variable = true }
      end, {
        expr = true,
        desc = 'Debug Print Variable',
      })
      vim.keymap.set('n', '<Leader>dV', function()
        return debugprint.debugprint { above = true, variable = true }
      end, {
        expr = true,
        desc = 'Debug Print Variable Above',
      })
      vim.keymap.set('n', '<leader>dq', '<CMD>DeleteDebugPrints<CR>', {
        desc = 'Delete Debug Prints',
      })
    end,
  },
}
