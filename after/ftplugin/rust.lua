local overseer = require("overseer")

overseer.register_template({
  name = "rust run project",
  builder = function()
    return {
      cmd = { "cargo", "run" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = "rust",
  },
})

overseer.register_template({
  name = "rust test",
  builder = function()
    return {
      cmd = { "cargo", "test" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "rust",
  },
})

overseer.register_template({
  name = "rust build",
  builder = function()
    return {
      cmd = { "cargo", "build" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "rust",
  },
})

overseer.register_template({
  name = "rust lint",
  builder = function()
    return {
      cmd = { "cargo", "clippy", "--", "-D", "warnings" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "rust",
  },
})

vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp("codeAction")
end, { silent = true, desc = "Rust Code Action" })

vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, desc = "Rust Hover documentation" })

vim.keymap.set("n", "<leader>ce", function()
  vim.cmd.RustLsp("explainError")
end, { desc = "Rust Explain error" })

vim.keymap.set("n", "<leader>co", function()
  vim.cmd.RustLsp("openCargo")
end, { desc = "Open cargo.toml" })

vim.keymap.set("n", "<leader>cd", function()
  vim.cmd.RustLsp("openDocs")
end, { desc = "Open Docs" })

vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({ name = "rust build" })
end, { buffer = true, desc = "Build Rust project" })

vim.keymap.set("n", "<leader>rt", function()
  overseer.run_template({ name = "rust test" })
end, { buffer = true, desc = "Run Rust tests" })

vim.keymap.set("n", "<leader>rr", function()
  overseer.run_template({ name = "rust run project" })
end, { buffer = true, desc = "Run Rust project" })

vim.keymap.set("n", "<leader>rl", function()
  overseer.run_template({ name = "rust lint" })
end, { buffer = true, desc = "Lint Rust code" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "cargo build"
vim.opt_local.errorformat = "%E%f:%l:%c: %*\\d:%*\\d error: %m,%W%f:%l:%c: %*\\d:%*\\d warning: %m,%C%*\\s--> %f:%l:%c"

