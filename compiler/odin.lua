if vim.fn.executable("odin") == 0 then
  return
end

vim.bo.makeprg = "odin build ."

vim.bo.errorformat = table.concat({
  "%f:%l:%c: %t%*[^:]: %m",
  "%f:%l: %t%*[^:]: %m",
  "%-G%.%#",
}, ",")