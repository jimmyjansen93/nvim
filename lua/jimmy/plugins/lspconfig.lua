return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
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

    lspconfig.yamlls.setup({
      filetypes = { ".clang-tidy" },
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/clang-tidy.json"] = ".clang-tidy",
          },
        },
      },
    })

    lspconfig.bashls.setup({})
    lspconfig.css_variables.setup({})
    lspconfig.cssls.setup({})
    lspconfig.cssmodules_ls.setup({})
    lspconfig.eslint.setup({})
    lspconfig.html.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.tailwindcss.setup({})
    lspconfig.vue_language_server.setup({})
    lspconfig.ts_ls.setup({})
    
    -- clangd for C/C++
    lspconfig.clangd.setup({
      cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_dir = require('lspconfig').util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
      ),
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      on_attach = function(client, bufnr)
        -- Switch between source and header
        vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", 
          { buffer = bufnr, desc = "Switch source/header" })
      end,
    })
  end,
}

