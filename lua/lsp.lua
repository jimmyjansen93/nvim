vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

vim.lsp.config("yamlls", {
  filetypes = { ".clang-tidy" },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/clang-tidy.json"] = ".clang-tidy",
      },
    },
  },
})

-- vim.lsp.config('clangd_custom', {
--   name = 'clangd_custom',
--   cmd = { '/opt/homebrew/opt/llvm/bin/clangd', '--std=c++23', '--background-index', '--pch-storage=memory', '--clang-tidy', '--log=error' },
--   filetypes = { 'c', 'cpp' },
--   root_markers = {
--     '.clangd',
--     '.clang-tidy',
--     '.clang-format',
--     '.git',
--   },
--   capabilities = {
--     textDocument = {
--       completion = {
--         editsNearCursor = true,
--       },
--     },
--     offsetEncoding = { 'utf-8', 'utf-16' },
--   },
--   on_init = function(client, init_result)
--     if init_result.offsetEncoding then
--       client.offset_encoding = init_result.offsetEncoding
--     end
--   end,
--   on_attach = function(_, bufnr)
--     vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
--       local method_name = 'textDocument/switchSourceHeader'
--       local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd_custom' })[1]
--       if not client then
--         return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
--       end
--       local params = vim.lsp.util.make_text_document_params(bufnr)
--       client:request(method_name, params, function(err, result)
--         if err then
--           error(tostring(err))
--         end
--         if not result then
--           vim.notify 'corresponding file cannot be determined'
--           return
--         end
--         vim.cmd.edit(vim.uri_to_fname(result))
--       end, bufnr)
--     end, { desc = 'Switch between source/header' })
--
--     vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdShowSymbolInfo', function()
--       local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd_custom' })[1]
--       if not clangd_client or not clangd_client:supports_method('textDocument/symbolInfo', bufnr) then
--         return vim.notify('Clangd client not found', vim.log.levels.ERROR)
--       end
--       local win = vim.api.nvim_get_current_win()
--       local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
--       clangd_client:request('textDocument/symbolInfo', params, function(err, res)
--         if err or #res == 0 then
--           return
--         end
--         local container = string.format('container: %s', res[1].containerName) ---@type string
--         local name = string.format('name: %s', res[1].name) ---@type string
--         vim.lsp.util.open_floating_preview({ name, container }, '', {
--           height = 2,
--           width = math.max(string.len(name), string.len(container)),
--           focusable = false,
--           focus = false,
--           border = 'single',
--           title = 'Symbol Info',
--         })
--       end, bufnr)
--     end, { desc = 'Show symbol info' })
--   end,
-- })

-- vim.lsp.config('clangd', { cmd = '/opt/homebrew/opt/llvm/bin/clangd' })

-- vim.lsp.config('nim_langserver', {
--   filetypes = { 'nim' },
--   settings = {
--     nim = {
--       timeout = 10000,
--       autoCheckFile = true,
--       autoCheckProject = true,
--       checkOnSave = true,
--       formatOnSave = true,
--     },
--   },
--   -- on_attach = function(_, bufnr)
--   --   local function expand_macro(level)
--   --     level = level or 1
--   --
--   --     local winid = vim.api.nvim_get_current_win()
--   --     local cur_buf = vim.api.nvim_get_current_buf()
--   --
--   --     local params = {
--   --       textDocument = vim.lsp.util.make_text_document_params(cur_buf),
--   --       position = vim.lsp.util.make_position_params(winid, 'utf-8'),
--   --       level = level,
--   --     }
--   --
--   --     vim.lsp.buf_request(cur_buf, 'extension/macroExpand', params, function(err, result)
--   --       if err then
--   --         vim.notify('Error expanding macro: ' .. err.message, vim.log.levels.ERROR)
--   --         return
--   --       end
--   --
--   --       if not result or not result.content then
--   --         vim.notify('Macro expansion did not return any content.', vim.log.levels.WARN)
--   --         return
--   --       end
--   --
--   --       local buf = vim.api.nvim_create_buf(false, true)
--   --
--   --       vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
--   --       vim.api.nvim_set_option_value('filetype', 'nim', { buf = buf })
--   --
--   --       vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result.content, '\n'))
--   --
--   --       local width = math.floor(vim.api.nvim_get_option_value('columns', {}) * 0.8)
--   --       local height = math.floor(vim.api.nvim_get_option_value('lines', {}) * 0.8)
--   --
--   --       vim.api.nvim_open_win(buf, true, {
--   --         relative = 'editor',
--   --         width = width,
--   --         height = height,
--   --         border = 'single',
--   --         style = 'minimal',
--   --       })
--   --     end)
--   --   end
--   --
--   --   vim.keymap.set('n', '<leader>cm', function()
--   --     expand_macro(1)
--   --   end, {
--   --     buffer = bufnr,
--   --     noremap = true,
--   --     silent = true,
--   --     desc = 'Expand Macro (1 level)',
--   --   })
--   --
--   --   vim.keymap.set('n', '<leader>cM', function()
--   --     expand_macro(99)
--   --   end, {
--   --     buffer = bufnr,
--   --     noremap = true,
--   --     silent = true,
--   --     desc = 'Expand Macro (Fully)',
--   --   })
--   -- end,
-- })

vim.lsp.config("zls", {
  settings = {
    zls = {
      enable_ast_check_diagnostics = true,
      enable_inlay_hints = true,
      semantic_tokens = "full",
      -- semantic_tokens = "partial",
      enable_build_on_save = true,
      warn_style = true,
    },
  },
})

-- vim.lsp.enable 'angularls'
-- vim.lsp.enable 'arduino_language_server'
vim.lsp.enable("bashls")
-- vim.lsp.enable 'nim_langserver'
-- vim.lsp.enable 'clangd'
-- vim.lsp.enable 'clangd_custom'
-- vim.lsp.enable 'cmake'
vim.lsp.enable("css_variables")
vim.lsp.enable("cssls")
vim.lsp.enable("cssmodules_ls")
-- vim.lsp.enable 'denols'
-- vim.lsp.enable 'docker_compose_language_service'
-- vim.lsp.enable 'dockerls'
vim.lsp.enable("eslint")
-- vim.lsp.enable 'gh_actions_ls'
-- vim.lsp.enable 'gitlab_ci_ls'
-- vim.lsp.enable 'gopls'
-- vim.lsp.enable 'graphql'
-- vim.lsp.enable 'helm_ls'
vim.lsp.enable("html")
-- vim.lsp.enable 'htmx'
-- vim.lsp.enable 'nginx_language_server'
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
-- vim.lsp.enable 'sqlls'
vim.lsp.enable("tailwindcss")
-- vim.lsp.enable 'terraform_ls'
vim.lsp.enable("vue_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("yamlls")
vim.lsp.enable("zls")
