return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",
        "nvim-telescope/telescope.nvim",
      },
      keys = {
        { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "Navigate code structure" },
      },
      config = function()
        local navbuddy = require("nvim-navbuddy")
        local actions = require("nvim-navbuddy.actions")

        navbuddy.setup({})
      end,
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local function custom_root_dir(patterns)
      return function(fname)
        local workspace_root =
          util.root_pattern("lerna.json", "pnpm-workspace.yaml", "rush.json", "nx.json", "yarn.lock")(fname)
        if workspace_root then
          return workspace_root
        end
        return util.root_pattern(unpack(patterns))(fname)
      end
    end

    local on_attach = function(client, bufnr)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Find references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover info" })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
      vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format({ async = true })
      end, { buffer = bufnr, desc = "Format buffer" })


      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
        require("nvim-navbuddy").attach(client, bufnr)
      end
    end

    if vim.fn.executable("lua-language-server") == 1 then
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
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
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, "${3rd}/luv/library", "${3rd}/busted/library" },
            },
          })
        end,
        settings = { Lua = {} },
      })
    else
      vim.notify("lua-language-server not found", vim.log.levels.WARN)
    end

    if vim.fn.executable("clangd") == 1 then
      lspconfig.clangd.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set(
            "n",
            "<leader>ch",
            "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Switch source/header" }
          )
        end,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        capabilities = { offsetEncoding = { "utf-16" } },
      })
    else
      vim.notify("clangd not found", vim.log.levels.WARN)
    end

    if vim.fn.executable("gopls") == 1 then
      lspconfig.gopls.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set(
            "n",
            "<leader>co",
            '<cmd>lua vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}})<cr>',
            { buffer = bufnr, desc = "Organize imports" }
          )
        end,
        root_dir = custom_root_dir({ "go.work", "go.mod", ".git" }),
        settings = {
          gopls = {
            gofumpt = true,
            analyses = { unusedparams = true },
            staticcheck = true,
            experimentalWorkspaceModule = true,
          },
        },
      })
    else
      vim.notify("gopls not found", vim.log.levels.WARN)
    end

    if vim.fn.executable("rust-analyzer") == 1 then
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { buildScripts = { enable = true } },
            procMacro = { enable = true },
            checkOnSave = { command = "clippy" },
          },
        },
      })
    else
      vim.notify("rust-analyzer not found", vim.log.levels.WARN)
    end


    if vim.fn.executable("typescript-language-server") == 1 then
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set(
            "n",
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true,
              })
            end,
            { buffer = bufnr, desc = "Organize imports" }
          )
          vim.keymap.set(
            "n", 
            "<leader>cU", 
            function()
              vim.lsp.buf.code_action({
                context = { only = { "source.removeUnused" } },
                apply = true,
              })
            end, 
            { buffer = bufnr, desc = "Remove unused" }
          )
        end,
        root_dir = custom_root_dir({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
        settings = {
          typescript = {
            preferences = {
              includePackageJsonAutoImports = "off",
            },
          },
          javascript = {
            preferences = {
              includePackageJsonAutoImports = "off",
            },
          },
        },
      })
    else
      vim.notify("typescript-language-server not found", vim.log.levels.WARN)
    end

    if vim.fn.executable("vscode-eslint-language-server") == 1 then
      lspconfig.eslint.setup({ 
        on_attach = on_attach,
        root_dir = custom_root_dir({ "package.json", ".eslintrc.js", ".eslintrc.json", ".git" }),
      })
    else
      vim.notify("vscode-eslint-language-server not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("bash-language-server") == 1 then
      lspconfig.bashls.setup({ on_attach = on_attach })
    else
      vim.notify("bash-language-server not found", vim.log.levels.WARN)
    end
    if vim.fn.executable("vscode-json-language-server") == 1 then
      lspconfig.jsonls.setup({ on_attach = on_attach })
    else
      vim.notify("vscode-json-language-server not found", vim.log.levels.WARN)
    end
    if vim.fn.executable("yaml-language-server") == 1 then
      lspconfig.yamlls.setup({ on_attach = on_attach })
    else
      vim.notify("yaml-language-server not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("vscode-html-language-server") == 1 then
      lspconfig.html.setup({ 
        on_attach = on_attach,
        filetypes = { "html", "htmldjango" },
      })
    else
      vim.notify("vscode-html-language-server not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("vscode-css-language-server") == 1 then
      lspconfig.cssls.setup({ 
        on_attach = on_attach,
        filetypes = { "css", "scss", "less" },
      })
    else
      vim.notify("vscode-css-language-server not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("vue-language-server") == 1 then
      lspconfig.volar.setup({
        on_attach = on_attach,
        cmd = { "vue-language-server", "--stdio" },
        filetypes = { "vue", "typescript", "javascript" },
        root_dir = custom_root_dir({ "package.json", "vue.config.js", "vite.config.js", "nuxt.config.js", ".git" }),
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      })
    end
    
    if vim.fn.executable("ngserver") == 1 then
      lspconfig.angularls.setup({
        on_attach = on_attach,
        root_dir = custom_root_dir({ "angular.json", "package.json", ".git" }),
      })
    end
    
    if vim.fn.executable("emmet-ls") == 1 then
      lspconfig.emmet_ls.setup({
        on_attach = on_attach,
        filetypes = { 
          "html", "htmldjango", "css", "scss", "sass", "less", 
          "javascript", "javascriptreact", "typescript", "typescriptreact", 
          "vue", "svelte" 
        },
      })
    end
    
    if vim.fn.executable("tailwindcss-language-server") == 1 then
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        filetypes = { 
          "html", "css", "scss", "sass", "less",
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "vue", "svelte"
        },
        root_dir = custom_root_dir({ "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" }),
      })
    end
    
    if vim.fn.executable("marksman") == 1 then
      lspconfig.marksman.setup({ on_attach = on_attach })
    else
      vim.notify("marksman not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("ols") == 1 then
      lspconfig.ols.setup({ on_attach = on_attach })
    else
      vim.notify("ols not found", vim.log.levels.WARN)
    end
    
    if vim.fn.executable("ocamllsp") == 1 then
      lspconfig.ocamllsp.setup({ on_attach = on_attach })
    else
      vim.notify("ocamllsp not found", vim.log.levels.WARN)
    end
  end,
}
