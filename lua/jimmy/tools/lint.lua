return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        c = { "cppcheck" },
        cpp = { "cppcheck" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        markdown = { "markdownlint" },
      }

      lint.linters.golangcilint = {
        cmd = "golangci-lint",
        stdin = false,
        args = { "run", "--out-format", "json" },
        stream = "stdout",
        ignore_exitcode = true,
        parser = function(output)
          local items = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded or not decoded.Issues then
            return items
          end

          for _, issue in ipairs(decoded.Issues) do
            table.insert(items, {
              source = "golangci-lint",
              lnum = issue.Pos.Line - 1,
              col = issue.Pos.Column - 1,
              end_lnum = issue.Pos.Line - 1,
              end_col = issue.Pos.Column - 1,
              severity = vim.diagnostic.severity.WARN,
              message = issue.Text .. " (" .. issue.FromLinter .. ")",
              user_data = { lsp = { code = issue.FromLinter } },
            })
          end
          return items
        end,
      }

      lint.linters.cppcheck = {
        cmd = "cppcheck",
        stdin = false,
        args = { "--enable=all", "--template=gcc", "--quiet" },
        stream = "stderr",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %t%*[^:]: %m"),
      }

      lint.linters.eslint = require("lint.linters.eslint")

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })

      local function lint_current_file()
        lint.try_lint()
        vim.notify("Linting current file...", vim.log.levels.INFO)
      end

      local function lint_project()
        local ft = vim.bo.filetype
        local cmd

        if ft == "go" then
          cmd = "golangci-lint run"
        elseif ft == "c" or ft == "cpp" then
          cmd = 'find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" | xargs cppcheck --enable=all'
        elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
          cmd = "eslint . --ext .js,.jsx,.ts,.tsx"
        elseif ft == "markdown" then
          cmd = "markdownlint ."
        else
          vim.notify("No project linter configured for " .. ft, vim.log.levels.WARN)
          return
        end

        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("Project linting completed successfully", vim.log.levels.INFO)
            else
              vim.notify("Project linting found issues", vim.log.levels.WARN)
              vim.cmd("copen")
            end
          end,
          stdout_buffered = true,
          stderr_buffered = true,
        })
      end

      vim.keymap.set("n", "<leader>cf", lint_current_file, { desc = "Lint current file" })
      vim.keymap.set("n", "<leader>cF", lint_project, { desc = "Lint project" })
    end,
  },
}
