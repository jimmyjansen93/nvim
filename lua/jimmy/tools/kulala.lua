return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  opts = {
    default_view = "body",
    default_env = "dev",
    debug = false,
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = { "jq", "." },
      },
      ["application/xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "-" },
      },
      ["text/html"] = {
        ft = "html",
        formatter = { "tidy", "-i", "-q", "-" },
      },
    },
    show_icons = "on_request",
    icons = {
      inlay = {
        loading = "⏳",
        done = "✅",
        error = "❌",
      },
      lualine = "🐼",
    },
    additional_curl_options = {},
    scratchpad_default_contents = {
      "@MY_TOKEN_NAME=my_token_value",
      "",
      "# @name scratchpad",
      "POST https://httpbin.org/post HTTP/1.1",
      "accept: application/json",
      "content-type: application/json",
      "",
      "{",
      '  "foo": "bar"',
      "}",
    },
    winbar = false,
    default_winbar_panes = { "body", "headers", "headers_body" },
  },
  config = function(_, opts)
    require("kulala").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function()
        vim.keymap.set("n", "<CR>", function()
          require("kulala").run()
        end, { buffer = 0, desc = "Run request" })

        vim.keymap.set("n", "[r", function()
          require("kulala").jump_prev()
        end, { buffer = 0, desc = "Previous request" })

        vim.keymap.set("n", "]r", function()
          require("kulala").jump_next()
        end, { buffer = 0, desc = "Next request" })

        vim.keymap.set("n", "<leader>kr", function() require('kulala').run() end, { buffer = 0, desc = "Run request" })
        vim.keymap.set("n", "<leader>kt", function() require('kulala').toggle_view() end, { buffer = 0, desc = "Toggle view" })
        vim.keymap.set("n", "<leader>kp", function() require('kulala').jump_prev() end, { buffer = 0, desc = "Previous request" })
        vim.keymap.set("n", "<leader>kn", function() require('kulala').jump_next() end, { buffer = 0, desc = "Next request" })
        vim.keymap.set("n", "<leader>kc", function() require('kulala').copy() end, { buffer = 0, desc = "Copy as curl" })
        vim.keymap.set("n", "<leader>ki", function() require('kulala').inspect() end, { buffer = 0, desc = "Inspect request" })
        vim.keymap.set("n", "<leader>ks", function() require('kulala').show_stats() end, { buffer = 0, desc = "Show stats" })
        vim.keymap.set("n", "<leader>kg", function() require('kulala').scratchpad() end, { buffer = 0, desc = "Open scratchpad" })
      end,
    })

    vim.filetype.add({
      extension = {
        ["http"] = "http",
        ["rest"] = "http",
      },
    })
  end,
}
