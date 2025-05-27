return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.freemarker = {
        install_info = {
          url = '~/projects/tools/tree-sitter-freemarker', -- local path or git repo
          files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          branch = 'main', -- default branch in case of git repo if different from master
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        filetype = 'ftl', -- if filetype does not match the parser name
      }
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

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
          },
        },
      }
    end,
  },
}
