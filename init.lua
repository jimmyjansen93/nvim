-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 999

--vim.o.filetype = 'plugin indent on'
vim.cmd 'filetype plugin indent on'
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit help with q',
  pattern = 'help,qf,netrw',
  group = vim.api.nvim_create_augroup('jj-help-utils', { clear = true }),
  callback = function()
    vim.keymap.set('n', 'q', '<C-w>c', { buffer = true, desc = '[q]uit' })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Stop commenting next line',
  group = vim.api.nvim_create_augroup('jj-comments', { clear = true }),
  command = [[set formatoptions -=cro]],
})

vim.api.nvim_create_autocmd('QuitPre', {
  pattern = '*.lua',
  group = vim.api.nvim_create_augroup('jj-autocommit-nvim', { clear = true }),
  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
})

vim.api.nvim_create_autocmd('QuitPre', {
  pattern = 'tmux.conf',
  group = vim.api.nvim_create_augroup('jj-autocommit-tmux', { clear = true }),
  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'numToStr/Comment.nvim', lazy = false, opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '▎' },
          change = { text = '▎' },
          delete = { text = '' },
          topdelete = { text = '' },
          changedelete = { text = '▎' },
          untracked = { text = '▎' },
        },
      }

      vim.keymap.set('n', '<leader>gp', '<CMD>lua require("gitsigns").preview_hunk()<CR>', { desc = 'Git preview hunk' })
      vim.keymap.set('n', '<leader>gt', '<CMD>lua require("gitsigns").toggle_current_line_blame()<CR>', { desc = 'Git toggle blame' })
      vim.keymap.set('n', '<leader>gl', '<CMD>lua require("gitsigns").setloclist()<CR>', { desc = 'Git loclist' })
      vim.keymap.set('n', ']c', '<CMD>lua require("gitsigns").next_hunk()<CR>', { desc = 'Git next change' })
      vim.keymap.set('n', '[c', '<CMD>lua require("gitsigns").prev_hunk()<CR>', { desc = 'Git prev change' })
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup { '*' }
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

  { 'anuvyklack/help-vsplit.nvim', opts = {
    always = true,
    side = 'right',
  } },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      disable_signs = false,
      graph_style = 'unicode',
    },
    keys = {
      { '<leader>gg', '<CMD>Neogit<CR>', desc = 'Open git window' },
    },
  },

  {
    'aserowy/tmux.nvim',
    opts = {
      copy_sync = {
        redirect_to_clipboard = true,
      },
      navigation = {
        enable_default_keybindings = true,
      },
    },
  },

  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics' },
      { '<leader>xL', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List' },
      { '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },

  {
    'gpanders/editorconfig.nvim',
  },

  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'BufReadPre',
    config = true,
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo Trouble' },
      { '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme Trouble' },
      { '<leader>xs', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
      { '<leader>xS', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
    },
  },

  {
    'LukasPietzschmann/boo.nvim',
    opts = {},
    keys = {
      { '<leader>K', '<cmd>lua require("boo").boo()<cr>', desc = 'Lsp Info' },
    },
  },

  {
    'IsWladi/Gittory',
    opts = {
      atStartUp = true,
      notifySettings = {
        enabled = false,
      },
    },
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
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
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
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
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

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'Run', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = 'File', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = 'Project', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'Snikimonkd/telescope-git-conflicts.nvim',
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
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['file_browser'] = {
            theme = 'ivy',
            hidden = { file_browser = true, folder_browser = true },
            hijack_netrw = true,
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'conflicts')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sc', '<CMD>Telescope conflicts<CR>', { desc = '[S]earch [C]onflicts' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = '[,] Find existing buffers' })

      -- Built spire without writing too much lua
      vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Find File' })
      -- A telescope keybinding on leader+ff that opens the file picker at the bottom of the screen with 100% and 30% height with the input at the top
      vim.keymap.set(
        'n',
        '<leader>fb',
        "<cmd>lua require('telescope').extensions.file_browser.file_browser { layout_config = { height = 0.5 } }<cr>",
        { desc = '[F]ile [B]rowser' }
      )

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
          previewer = false,
          layout_strategy = 'center',
          layout_config = { width = 0.6, height = 0.6 },
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { 'sitiom/nvim-numbertoggle' },

  {
    'pmizio/typescript-tools.nvim',
    event = 'BufEnter *.ts,*.tsx',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  { 'dmmulroy/tsc.nvim', dependencies = { 'rcarriga/nvim-notify' }, opts = {} },

  { 'dmmulroy/ts-error-translator.nvim' },

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },

  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {}, -- your configuration
  },

  {
    'catgoose/do-the-needful.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>;', [[<cmd>Telescope do-the-needful please<cr>]], 'n' },
      { '<leader>:', [[<cmd>Telescope do-the-needful<cr>]], 'n' },
    },
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      tasks = {
        {
          name = 'ripgrep current directory',
          cmd = 'rg ${pattern} ${cwd}',
          tags = { 'ripgrep', 'cwd', 'search', 'pattern' },
          ask = {
            ['${pattern}'] = {
              title = 'Pattern to use',
              default = 'error',
            },
          },
          window = {
            name = 'Ripgrep',
            close = false,
            keep_current = true,
          },
        },
      },
      edit_mode = 'buffer', -- buffer, tab, split, vsplit
      config_file = '.tasks.json', -- name of json config file for project/global config
      config_order = { -- default: { project, global, opts }.  Order in which
        -- tasks are aggregated
        'project', -- .task.json in project directory
        'global', -- .tasks.json in stdpath('data')
        'opts', -- tasks defined in setup opts
      },
      tag_source = true, -- display #project, #global, or #opt after tags
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
    },
  },

  {
    'nvimtools/hydra.nvim',
    config = function()
      local hydra = require 'hydra'

      hydra.setup {
        debug = false,
        exit = false,
        foreign_keys = nil,
        color = 'red',
        timeout = false,
        invoke_on_body = false,
        hint = {
          show_name = true,
          position = { 'bottom' },
          offset = 0,
          float_opts = {},
        },
        on_enter = nil,
        on_exit = nil,
        on_key = nil,
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'artemave/workspace-diagnostics.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('<leader>cd', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>cr', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('lspconfig').astro.setup {}

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            -- FIXME: just an experiment to see if this works
            server.on_attach = function(client, bufnr)
              require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
            end
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'eslintd', 'eslint' }, { 'prettierd', 'prettier' } },
      },
    },
  },

  { -- Autocompletion
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

      {
        'L3MON4D3/LuaSnip',
        build = (function()
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

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
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      luasnip.config.setup {}

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
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['C-o'] = cmp.mapping.complete {},

          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'npm', keyword_length = 4 },
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        highlight_overrides = {
          all = {
            LineNr = { fg = '#8aadf4' },
            CursorLineNr = { fg = '#ed8796' },
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

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
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, { checker = { notify = false } })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
