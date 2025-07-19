if vim.b.current_compiler == "zig" then
  return
end
vim.b.current_compiler = "zig"

local save_cpo = vim.o.cpoptions
vim.o.cpoptions = vim.o.cpoptions:gsub("[cC]", "")

vim.bo.makeprg = "zig build"

local errorformat_patterns = {
  "%f:%l:%c: %t%*[^:]: %m",
  "%f:%l:%c: 0x%*[0-9a-fA-F] in %m",

  "%-Gerror: '%*[^']' leaked: %.%#",
  "%-Gthread %*[0-9] panic: %.%#",

  "%-G%.%#",
}

vim.bo.errorformat = table.concat(errorformat_patterns, ",")

vim.cmd([[
  command! -buffer -nargs=* ZigBuild compiler zig | setlocal makeprg=zig\ build | make! <args>
  command! -buffer ZigRun compiler zig | setlocal makeprg=zig\ build\ run | make!
  command! -buffer ZigTest compiler zig | setlocal makeprg=zig\ build\ test | make!
  command! -buffer ZigTestFuzz compiler zig | setlocal makeprg=zig\ build\ test\ --fuzz | make!
  command! -buffer ZigBuildExe compiler zig | exe 'setlocal makeprg=zig\ build-exe\ ' . expand('%') | make!
  command! -buffer ZigRunFile compiler zig | exe 'setlocal makeprg=zig\ run\ ' . expand('%') | make!
  command! -buffer ZigTestFile compiler zig | exe 'setlocal makeprg=zig\ test\ ' . expand('%') | make!
]])

vim.o.cpoptions = save_cpo
