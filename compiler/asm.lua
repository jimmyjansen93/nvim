vim.bo.makeprg = "nasm -f elf64 -o %< %"

vim.bo.errorformat = "%f:%l: %t%*[^:]: %m"
