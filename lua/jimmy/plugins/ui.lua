return {
  {
    'folke/noice.nvim',
    disabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    opts = {
      lsp = {
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      notify = {
        enabled = false,
      },
      message = {
        enabled = false,
      },
    },

    keys = {
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Noise Redirect Cmdline',
      },
      {
        '<leader>qm',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>qh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Noice History',
      },
      {
        '<leader>qo',
        function()
          require('noice').cmd 'all'
        end,
        desc = 'Noice All',
      },
      {
        '<leader>qg',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Noice Dismiss All',
      },
      {
        '<c-f>',
        silent = true,
        expr = true,
        desc = 'Scroll Forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<c-b>',
        silent = true,
        expr = true,
        desc = 'Scroll Backward',
        mode = { 'i', 'n', 's' },
      },
    },
  },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = ' '
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     -- PERF: we don't need this lualine require madness 🤷
  --     local lualine_require = require 'lualine_require'
  --     lualine_require.require = require
  --
  --     vim.o.laststatus = vim.g.lualine_laststatus
  --
  --     return {
  --       options = {
  --         theme = 'auto',
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
  --       },
  --       sections = {
  --         lualine_a = { 'mode' },
  --         lualine_b = { 'branch' },
  --
  --         lualine_c = {
  --           LazyVim.lualine.root_dir(),
  --           {
  --             'diagnostics',
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
  --           { LazyVim.lualine.pretty_path() },
  --         },
  --         lualine_x = {
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.command.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --           color = LazyVim.ui.fg("Statement"),
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.mode.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --           color = LazyVim.ui.fg("Constant"),
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return "  " .. require("dap").status() end,
  --           cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
  --           color = LazyVim.ui.fg("Debug"),
  --         },
  --           {
  --             require('lazy.status').updates,
  --             cond = require('lazy.status').has_updates,
  --             color = LazyVim.ui.fg 'Special',
  --           },
  --           {
  --             'diff',
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --             source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end,
  --           },
  --         },
  --         lualine_y = {
  --           { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
  --           { 'location', padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return ' ' .. os.date '%R'
  --           end,
  --         },
  --       },
  --       extensions = { 'neo-tree', 'lazy' },
  --     }
  --   end,
  -- },
}
