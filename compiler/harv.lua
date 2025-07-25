if vim.b.current_compiler == "harv" then
  return
end
vim.b.current_compiler = "harv"

vim.bo.makeprg = "./build run"

local errorformat_patterns = {
  -- clang
  "%E%f:%l:%c: error: %m",
  "%W%f:%l:%c: warning: %m",
  "%I%f:%l:%c: note: %m",
  "%C%p%*[^ ]",
  "%C %m",
  "%f:%l:%c: %t: %m",
  "%f:%l: undefined reference to %m",
  "/usr/bin/ld: %f:%l: %m",
  "ld: %f:%l: %m",
  "ld: %m",
  "collect2: error: %m",
  "Undefined symbols for architecture %m",
  "%IIn file included from %f:%l:%c:",
  "%IIn file included from %f:%l:",
  "%f:%l:%c: %m",
  "%f:%l: %m",
  -- gcc
  '%*[^"]"%f"%*\\D%l:%c: %m',
  '%*[^"]"%f"%*\\D%l: %m',
  '\\"%f\\"%*\\D%l:%c: %m',
  '\\"%f\\"%*\\D%l: %m',
  "%-G%f:%l: %trror: %%(Each undeclared identifier is reported only once,",
  "%-G%f:%l: %trror: for each function it appears in.)",
  "%f:\\(%*[^\\)]\\): %m",
  '\\"%f\\", line %l%*\\D%c%*[^ ] %m',
  "%DMaking %*\\a in %f",
  "%DEntering directory %*[`']%f'",
  "%XLeaving directory %*[`']%f'",
  -- Ignore the rest
  "%-G%.%#",
}

vim.bo.errorformat = table.concat(errorformat_patterns, ",")
