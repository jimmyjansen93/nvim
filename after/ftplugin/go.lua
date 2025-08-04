local overseer = require("overseer")

overseer.register_template({
  name = "go run project",
  builder = function()
    return {
      cmd = { "go", "run", "." },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = "go",
  },
})

overseer.register_template({
  name = "go test",
  builder = function()
    return {
      cmd = { "go", "test", "-v", "./..." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "go",
  },
})

overseer.register_template({
  name = "go build",
  builder = function()
    return {
      cmd = { "go", "build", "./..." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "go",
  },
})

overseer.register_template({
  name = "go lint",
  builder = function()
    return {
      cmd = { "golangci-lint", "run", "--out-format=colored-line-number" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "go",
  },
})

vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({ name = "go build" })
end, { buffer = true, desc = "Build Go project" })

vim.keymap.set("n", "<leader>rt", function()
  overseer.run_template({ name = "go test" })
end, { buffer = true, desc = "Run Go tests" })

vim.keymap.set("n", "<leader>rr", function()
  overseer.run_template({ name = "go run project" })
end, { buffer = true, desc = "Run Go project" })

vim.keymap.set("n", "<leader>rl", function()
  overseer.run_template({ name = "go lint" })
end, { buffer = true, desc = "Lint Go code" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "go build"
vim.opt_local.errorformat = "%f:%l:%c: %m,%f:%l: %m"

