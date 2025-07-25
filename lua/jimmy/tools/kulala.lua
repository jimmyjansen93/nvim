return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  keys = {
    { "<leader>kr", "<cmd>lua require('kulala').run()<cr>", desc = "Run request" },
    { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle view" },
    { "<leader>kp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Previous request" },
    { "<leader>kn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next request" },
    { "<leader>kc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as curl" },
    { "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect request" },
    { "<leader>ks", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats" },
    { "<leader>kg", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
  },
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
