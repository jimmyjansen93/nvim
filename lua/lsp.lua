vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          '${3rd}/busted/library',
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- vim.lsp.enable 'angularls'
-- vim.lsp.enable 'arduino_language_server'
vim.lsp.enable 'bashls'
vim.lsp.enable 'clangd'
vim.lsp.enable 'cmake'
vim.lsp.enable 'css_variables'
vim.lsp.enable 'cssls'
vim.lsp.enable 'cssmodules_ls'
-- vim.lsp.enable 'denols'
-- vim.lsp.enable 'docker_compose_language_service'
-- vim.lsp.enable 'dockerls'
vim.lsp.enable 'eslint'
-- vim.lsp.enable 'gh_actions_ls'
-- vim.lsp.enable 'gitlab_ci_ls'
-- vim.lsp.enable 'gopls'
-- vim.lsp.enable 'graphql'
-- vim.lsp.enable 'helm_ls'
vim.lsp.enable 'html'
-- vim.lsp.enable 'htmx'
-- vim.lsp.enable 'nginx_language_server'
vim.lsp.enable 'jsonls'
vim.lsp.enable 'lua_ls'
-- vim.lsp.enable 'sqlls'
vim.lsp.enable 'tailwindcss'
-- vim.lsp.enable 'terraform_ls'
vim.lsp.enable 'vue_ls'
vim.lsp.enable 'ts_ls'
vim.lsp.enable 'yamlls'
