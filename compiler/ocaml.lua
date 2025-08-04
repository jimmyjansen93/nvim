if vim.fn.executable("dune") == 0 and vim.fn.executable("ocaml") == 0 then
  return
end

local function is_dune_project()
  local dune_files = vim.fs.find({ "dune-project", "dune" }, { upward = true, stop = vim.fn.expand("~"), type = "file", limit = 3 })
  return #dune_files > 0
end

if is_dune_project() then
  vim.bo.makeprg = "dune build"
else
  vim.bo.makeprg = "ocamlopt -o " .. vim.fn.expand("%:r") .. " " .. vim.fn.expand("%")
end

vim.bo.errorformat = table.concat({
  "%f:%l:%c: %t%*[^:]: %m",
  "%f:%l: %t%*[^:]: %m",
  "%-G%.%#",
}, ",")