if vim.fn.executable("dune") == 0 and vim.fn.executable("ocaml") == 0 then
  return
end

local overseer = require("overseer")

local function is_dune_project()
  local dune_files = vim.fs.find({ "dune-project", "dune" }, { upward = true, stop = vim.fn.expand("~"), type = "file", limit = 3 })
  return #dune_files > 0
end

local function get_build_cmd()
  if is_dune_project() then
    return { "dune", "build" }
  else
    return { "ocamlopt", "-o", vim.fn.expand("%:r"), vim.fn.expand("%") }
  end
end

overseer.register_template({
  name = "ocaml build project",
  builder = function()
    return {
      cmd = get_build_cmd(),
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "ocaml",
  },
})

overseer.register_template({
  name = "ocaml run project",
  builder = function()
    if is_dune_project() then
      return {
        cmd = { "dune", "exec", "." },
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    else
      return {
        cmd = { "./" .. vim.fn.expand("%:r") },
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end
  end,
  condition = {
    filetype = "ocaml",
  },
})

overseer.register_template({
  name = "ocaml test",
  builder = function()
    return {
      cmd = { "dune", "test" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "ocaml",
  },
})

overseer.register_template({
  name = "ocaml runtest",
  builder = function()
    return {
      cmd = { "dune", "runtest" },
      components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
    }
  end,
  condition = {
    filetype = "ocaml",
  },
})

vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({ name = "ocaml build project" })
end, { buffer = true, desc = "Build OCaml project" })

vim.keymap.set("n", "<leader>rr", function()
  overseer.run_template({ name = "ocaml run project" })
end, { buffer = true, desc = "Run OCaml project" })

vim.keymap.set("n", "<leader>rt", function()
  overseer.run_template({ name = "ocaml test" })
end, { buffer = true, desc = "Run OCaml tests" })

vim.keymap.set("n", "<leader>rc", function()
  overseer.run_template({ name = "ocaml runtest" })
end, { buffer = true, desc = "Run OCaml runtest" })

vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

if is_dune_project() then
  vim.opt_local.makeprg = "dune build"
else
  vim.opt_local.makeprg = "ocamlopt -o " .. vim.fn.expand("%:r") .. " " .. vim.fn.expand("%")
end
vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m"