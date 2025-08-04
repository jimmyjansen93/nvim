return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      local luasnip = require("luasnip")

      luasnip.setup({
        history = true,
        delete_check_events = "TextChanged",
        region_check_events = "CursorMoved",
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })

      require("luasnip.loaders.from_vscode").lazy_load()

      local snippet_path = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })

      vim.keymap.set("n", "<leader>cs", function()
        require("luasnip.loaders").edit_snippet_files()
      end, { desc = "Edit snippets" })

      vim.keymap.set("n", "<leader>cS", function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })
        vim.notify("Snippets reloaded", vim.log.levels.INFO)
      end, { desc = "Reload snippets" })

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = snippet_path .. "/*.json",
        callback = function()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })
          vim.notify("Snippets auto-reloaded", vim.log.levels.INFO)
        end,
      })
    end,
  },
}
