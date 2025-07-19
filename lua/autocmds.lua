vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("jj-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Quit help with q",
  pattern = "help,qf,netrw",
  group = vim.api.nvim_create_augroup("jj-help-utils", { clear = true }),
  callback = function()
    vim.keymap.set("n", "q", "<C-w>c", { buffer = true, desc = "quit" })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Stop commenting next line",
  group = vim.api.nvim_create_augroup("jj-comments", { clear = true }),
  command = [[set formatoptions -=cro]],
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Disable diagnostic in node_modules",
  pattern = "*/node_modules/*",
  command = "lua vim.diagnostic.disable(0)",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto import for go files",
  pattern = "*.go",
  group = vim.api.nvim_create_augroup("goimports", {}),
  callback = function()
    require("go.format").goimports()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("jimmy-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end

    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")

    local capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
      root_markers = { ".git" },
    }

    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    vim.lsp.config("*", capabilities)

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("jimmy-quickfix", { clear = true }),
  desc = "Auto open quickfix",
  callback = function()
    vim.cmd("Trouble qflist open focus=true")
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.zig,*.zon",
  callback = function()
    vim.cmd([[setfiletype zig]])
  end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.zig,*.zon",
  callback = function()
    vim.cmd([[setfiletype zig]])
  end,
})
