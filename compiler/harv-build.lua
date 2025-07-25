if vim.b.current_compiler == "harv-build" then
  return
end
vim.b.current_compiler = "harv-build"

vim.bo.makeprg = "clang++ -I/opt/homebrew/include -std=c++23 -Wall -Wextra -Wno-main -g build.cpp -o build"

local errorformat_patterns = {
  '%*[^"]"%f"%*\\D%l:%c: %m',
  '%*[^"]"%f"%*\\D%l: %m',
  '\\"%f\\"%*\\D%l:%c: %m',
  '\\"%f\\"%*\\D%l: %m',
  "%-G%f:%l: %trror: %%(Each undeclared identifier is reported only once,",
  "%-G%f:%l: %trror: for each function it appears in.)",
  "%f:%l:%c: %trror: %m",
  "%f:%l:%c: %tarning: %m",
  "%f:%l:%c: %m",
  "%f:%l: %trror: %m",
  "%f:%l: %tarning: %m",
  "%f:%l: %m",
  "%f:\\(%*[^\\)]\\): %m",
  '\\"%f\\", line %l%*\\D%c%*[^ ] %m',
  "%D%*\\a[%*\\d]: Entering directory %*[`']%f'",
  "%X%*\\a[%*\\d]: Leaving directory %*[`']%f'",
  "%D%*\\a: Entering directory %*[`']%f'",
  "%X%*\\a: Leaving directory %*[`']%f'",
  "%DMaking %*\\a in %f",
}

if vim.g.compiler_gcc_ignore_unmatched_lines ~= nil then
  table.insert(errorformat_patterns, "%-G%.%#")
end

vim.bo.errorformat = table.concat(errorformat_patterns, ",")
