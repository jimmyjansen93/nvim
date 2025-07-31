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
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
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

    lspconfig.zls.setup({ on_attach = on_attach })

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
          "<leader>cu", 
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

    lspconfig.eslint.setup({ 
      on_attach = on_attach,
      root_dir = custom_root_dir({ "package.json", ".eslintrc.js", ".eslintrc.json", ".git" }),
    })
    
    lspconfig.bashls.setup({ on_attach = on_attach })
    lspconfig.jsonls.setup({ on_attach = on_attach })
    lspconfig.yamlls.setup({ on_attach = on_attach })
    
    lspconfig.html.setup({ 
      on_attach = on_attach,
      filetypes = { "html", "htmldjango" },
    })
    
    lspconfig.cssls.setup({ 
      on_attach = on_attach,
      filetypes = { "css", "scss", "less" },
    })
    
    -- Vue support (Volar)
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
    
    -- Angular support (optional)
    if vim.fn.executable("ngserver") == 1 then
      lspconfig.angularls.setup({
        on_attach = on_attach,
        root_dir = custom_root_dir({ "angular.json", "package.json", ".git" }),
      })
    end
    
    -- Emmet support (optional)
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
    
    -- Tailwind CSS support (optional)
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
    
    lspconfig.marksman.setup({ on_attach = on_attach })
  end,
}
