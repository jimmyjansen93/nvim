if vim.fn.executable("odin") == 0 then
  return
end

local overseer = require("overseer")

overseer.register_template({
  name = "odin build project",
  builder = function()
    return {
      cmd = { "odin", "build", "." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "odin",
  },
})

overseer.register_template({
  name = "odin run project",
  builder = function()
    return {
      cmd = { "odin", "run", "." },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = "odin",
  },
})

overseer.register_template({
  name = "odin test",
  builder = function()
    return {
      cmd = { "odin", "test", "." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "odin",
  },
})

overseer.register_template({
  name = "odin check",
  builder = function()
    return {
      cmd = { "odin", "check", "." },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "odin",
  },
})

vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({ name = "odin build project" })
end, { buffer = true, desc = "Build Odin project" })

vim.keymap.set("n", "<leader>rr", function()
  overseer.run_template({ name = "odin run project" })
end, { buffer = true, desc = "Run Odin project" })

vim.keymap.set("n", "<leader>rt", function()
  overseer.run_template({ name = "odin test" })
end, { buffer = true, desc = "Run Odin tests" })

vim.keymap.set("n", "<leader>rc", function()
  overseer.run_template({ name = "odin check" })
end, { buffer = true, desc = "Check Odin code" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "odin build ."
vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m"