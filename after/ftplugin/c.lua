vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

if vim.fn.executable("clang-format") == 1 then
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m,%f:(%l\\,%c): %t%*[^:]: %m"

vim.keymap.set("n", "<leader>cr", "<cmd>!gcc -o %< % && ./%<<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set(
  "n",
  "<leader>cc",
  "<cmd>!gcc -Wall -Wextra -std=c99 % -o %:r<cr>",
  { buffer = true, desc = "Compile file" }
)

if vim.fn.expand("%:e") == "h" then
  vim.keymap.set("n", "<leader>cg", function()
    local guard = string.upper(vim.fn.expand("%:t:r")) .. "_H"
    local lines = {
      "#ifndef " .. guard,
      "#define " .. guard,
      "",
      "",
      "",
      "#endif /* " .. guard .. " */",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.api.nvim_win_set_cursor(0, { 4, 0 })
  end, { buffer = true, desc = "Insert include guard" })
end

