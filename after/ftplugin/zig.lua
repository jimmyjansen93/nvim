local overseer = require("overseer")

overseer.register_template({
  name = "zig run project",
  builder = function()
    return {
      cmd = { "zig", "build", "run" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = "zig",
  },
})

overseer.register_template({
  name = "zig test",
  builder = function()
    return {
      cmd = { "zig", "test", vim.fn.expand("%") },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "zig",
  },
})

overseer.register_template({
  name = "zig build",
  builder = function()
    return {
      cmd = { "zig", "build" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "zig",
  },
})

overseer.register_template({
  name = "zig lint",
  builder = function()
    return {
      cmd = { "zig", "fmt", "--check", "." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "zig",
  },
})

vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({ name = "zig build" })
end, { buffer = true, desc = "Build Zig project" })

vim.keymap.set("n", "<leader>rt", function()
  overseer.run_template({ name = "zig test" })
end, { buffer = true, desc = "Run Zig tests" })

vim.keymap.set("n", "<leader>rr", function()
  overseer.run_template({ name = "zig run project" })
end, { buffer = true, desc = "Run Zig project" })

vim.keymap.set("n", "<leader>rl", function()
  overseer.run_template({ name = "zig lint" })
end, { buffer = true, desc = "Lint Zig code" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "zig build"
vim.opt_local.errorformat = "%f:%l:%c: error: %m,%f:%l:%c: note: %m"