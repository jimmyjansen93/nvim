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
    'Zeioth/compiler.nvim',
    dependencies = { 'stevearc/overseer.nvim' },
    config = function()
      require('compiler').setup {}
      vim.keymap.set('n', '<leader>rr', '<CMD>CompilerOpen<CR>', { desc = 'Compiler open' })
      vim.keymap.set('n', '<leader>rs', '<CMD>CompilerStop<CR>' .. '<cmd>CompilerRedo<cr>', { desc = 'Compiler restart' })
      vim.keymap.set('n', '<leader>rt', '<CMD>CompilerToggleResults<CR>', { desc = 'Compiler results' })
    end,
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
}
