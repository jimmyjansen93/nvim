return {
  {
    'neovim/nvim-lspconfig',
  },
  {
    'ray-x/go.nvim',
    enabled = false,
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },

    config = function()
      require('go').setup {}
      require('go.format').goimports()
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    enabled = false,
    opts = {},
  },
  {
    'pmizio/typescript-tools.nvim',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  { 'dmmulroy/tsc.nvim', enabled = false, dependencies = { 'rcarriga/nvim-notify' }, opts = {} },
  { 'dmmulroy/ts-error-translator.nvim', enabled = false },

  -- TODO: Tie this into Blink.cmp for autocomplete
  {
    'heilgar/nvim-http-client',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    event = 'VeryLazy',
    ft = { 'http', 'rest' },
    config = function()
      require('http_client').setup {
        default_env_file = '.env.json',
        request_timeout = 30000,
        split_direction = 'right',
        create_keybindings = true,

        profiling = {
          enabled = true,
          show_in_response = true,
          detailed_metrics = true,
        },

        keybindings = {
          select_env_file = '<leader>hf',
          set_env = '<leader>he',
          run_request = '<leader>hr',
          stop_request = '<leader>hx',
          toggle_verbose = '<leader>hv',
          toggle_profiling = '<leader>hp',
          dry_run = '<leader>hd',
          copy_curl = '<leader>hc',
          save_response = '<leader>hs',
        },
      }

      if pcall(require, 'telescope') then
        require('telescope').load_extension 'http_client'
      end
    end,
  },
}
