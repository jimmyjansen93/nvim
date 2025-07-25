vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.keymap.set("n", "<leader>cf", "<cmd>%!jq .<cr>", { buffer = true, desc = "Format JSON with jq" })

vim.keymap.set("n", "<leader>cc", "<cmd>!jq . %<cr>", { buffer = true, desc = "Validate JSON" })

if vim.fn.executable("jq") == 1 then
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local content = table.concat(lines, "\n")

      local handle = io.popen("echo '" .. content:gsub("'", "'\"'\"'") .. "' | jq . 2>/dev/null")
      local result = handle:read("*a")
      handle:close()

      if result and result ~= "" then
        vim.lsp.buf.format({ async = false })
      end
    end,
  })
end
