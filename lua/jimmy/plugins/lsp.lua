return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'artemave/workspace-diagnostics.nvim',
    },
    config = function(_, opts)
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },

        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'clangd',
        'cmake',
        'gopls',
        'html',
        'jsonls',
        'marksman',
        'prismals',
        'cssls',
        'sqlls',
        'yamlls',
        'bashls',
        'zls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed, auto_install = false }

      require('mason-lspconfig').setup {
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = function(client, bufnr)
              require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
              vim.lsp.inlay_hint.enable(true)
            end
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = false,
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config { virtual_lines = true }
      vim.diagnostic.config { virtual_text = false }

      vim.keymap.set('', '<Leader>cl', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
    end,
  },
}
