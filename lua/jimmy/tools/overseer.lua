return {
  "stevearc/overseer.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  keys = {
    { "<leader>rb", desc = "Build project" },
    { "<leader>rt", desc = "Run tests" },
    { "<leader>rr", desc = "Run current file" },
    { "<leader>rl", desc = "Lint project" },
    { "<leader>rs", desc = "Toggle overseer" },
    { "<leader>ro", desc = "Run task" },
    { "<leader>rq", desc = "Quick action" },
    { "<leader>ra", desc = "Task action" },
  },
  opts = {
    templates = { "builtin", "user.run_script", "user.make", "user.test", "user.lint" },
    strategy = {
      "toggleterm",
      direction = "horizontal",
      auto_scroll = true,
      quit_on_exit = "success",
    },
    component_aliases = {
      default = {
        "display_duration",
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        "on_complete_dispose",
      },
    },
  },
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  config = function(_, opts)
    local overseer = require("overseer")

    overseer.setup(opts)

    overseer.register_template({
      name = "run current file",
      builder = function()
        local ft = vim.bo.filetype
        local file = vim.fn.expand("%")
        local cmd = {}

        if ft == "go" then
          cmd = { "go", "run", file }
        elseif ft == "rust" then
          local basename = vim.fn.expand("%:t:r")
          cmd = { "sh", "-c", "rustc " .. file .. " && ./" .. basename }
        elseif ft == "javascript" then
          cmd = { "node", file }
        elseif ft == "typescript" then
          cmd = { "npx", "tsx", file }
        elseif ft == "zig" then
          cmd = { "zig", "run", file }
        elseif ft == "c" then
          local basename = vim.fn.expand("%:t:r")
          cmd = { "sh", "-c", "gcc -o " .. basename .. " " .. file .. " && ./" .. basename }
        elseif ft == "cpp" then
          local basename = vim.fn.expand("%:t:r")
          cmd = { "sh", "-c", "g++ -o " .. basename .. " " .. file .. " && ./" .. basename }
        elseif ft == "nim" then
          cmd = { "nim", "r", file }
        elseif ft == "asm" then
          local basename = vim.fn.expand("%:t:r")
          cmd = { "sh", "-c", "make && ./" .. basename }
        elseif ft == "lua" then
          cmd = { "lua", file }
        else
          vim.notify("No run command configured for " .. ft, vim.log.levels.WARN)
          return nil
        end

        return {
          cmd = cmd,
          components = { { "on_output_quickfix", open = true }, "default" },
        }
      end,
      condition = {
        filetype = { "go", "rust", "javascript", "typescript", "zig", "c", "cpp", "nim", "asm", "lua" },
      },
    })

    overseer.register_template({
      name = "run tests",
      builder = function()
        local ft = vim.bo.filetype
        local cmd = {}

        if ft == "go" then
          cmd = { "go", "test", "-v", "./..." }
        elseif ft == "rust" then
          cmd = { "cargo", "test" }
        elseif ft == "javascript" or ft == "typescript" then
          cmd = { "npm", "test" }
        elseif ft == "zig" then
          cmd = { "zig", "test", vim.fn.expand("%") }
        elseif ft == "c" or ft == "cpp" then
          cmd = { "make", "test" }
        elseif ft == "nim" then
          local nimble_files =
            vim.fs.find("%.nimble", { upward = true, stop = vim.fn.expand("~"), type = "file", limit = 3 })
          if #nimble_files > 0 then
            cmd = { "nimble", "test" }
          else
            cmd = { "nim", "c", "-r", "--hints:off", vim.fn.expand("%") }
          end
        else
          vim.notify("No test command configured for " .. ft, vim.log.levels.WARN)
          return nil
        end

        return {
          cmd = cmd,
          components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
        }
      end,
      condition = {
        filetype = { "go", "rust", "javascript", "typescript", "zig", "c", "cpp", "nim" },
      },
    })

    overseer.register_template({
      name = "lint",
      builder = function()
        local ft = vim.bo.filetype
        local cmd = {}

        if ft == "go" then
          cmd = { "golangci-lint", "run", "--out-format=colored-line-number" }
        elseif ft == "c" or ft == "cpp" then
          cmd = {
            "sh",
            "-c",
            'find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" | head -20 | xargs cppcheck --enable=all --template=gcc',
          }
        elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
          cmd = { "eslint", ".", "--ext", ".js,.jsx,.ts,.tsx", "--format=compact" }
        elseif ft == "rust" then
          cmd = { "cargo", "clippy", "--", "-D", "warnings" }
        elseif ft == "zig" then
          cmd = { "zig", "fmt", "--check", "." }
        elseif ft == "nim" then
          cmd = { "nim", "check", vim.fn.expand("%") }
        elseif ft == "lua" then
          cmd = { "luacheck", "." }
        else
          vim.notify("No linter configured for " .. ft, vim.log.levels.WARN)
          return nil
        end

        return {
          cmd = cmd,
          components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
        }
      end,
      condition = {
        filetype = {
          "go",
          "c",
          "cpp",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "rust",
          "zig",
          "nim",
          "lua",
        },
      },
    })

    overseer.register_template({
      name = "build project",
      builder = function()
        local function find_project_file(patterns)
          local current_dir = vim.fn.expand("%:p:h")
          while current_dir ~= "/" do
            for _, pattern in ipairs(patterns) do
              if vim.uv.fs_stat(current_dir .. "/" .. pattern) then
                return current_dir, pattern
              end
            end
            current_dir = vim.fn.fnamemodify(current_dir, ":h")
          end
          return nil, nil
        end

        local project_dir, project_file = find_project_file({
          "package.json",
          "Cargo.toml",
          "go.mod",
          "pyproject.toml",
          "Makefile",
          "build.zig",
        })

        if not project_dir then
          vim.notify("No project file found", vim.log.levels.WARN)
          return nil
        end

        local cmd = {}
        local cwd = project_dir

        if project_file == "package.json" then
          cmd = { "npm", "run", "build" }
        elseif project_file == "Cargo.toml" then
          cmd = { "cargo", "build" }
        elseif project_file == "go.mod" then
          cmd = { "go", "build", "./..." }
        elseif project_file == "pyproject.toml" then
          cmd = { "python", "-m", "build" }
        elseif project_file == "Makefile" then
          cmd = { "make" }
        elseif project_file == "build.zig" then
          cmd = { "zig", "build" }
        end

        return {
          cmd = cmd,
          cwd = cwd,
          name = "Build (" .. vim.fn.fnamemodify(project_dir, ":t") .. ")",
          components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" },
        }
      end,
      condition = {
        callback = function()
          return vim.uv.fs_stat("Makefile")
            or vim.uv.fs_stat("makefile")
            or vim.uv.fs_stat("Cargo.toml")
            or vim.uv.fs_stat("go.mod")
            or vim.uv.fs_stat("package.json")
            or vim.uv.fs_stat("build.zig")
            or vim.uv.fs_stat("CMakeLists.txt")
            or vim.fn.glob("*.nimble") ~= ""
            or vim.tbl_contains(
              { "c", "cpp", "go", "rust", "javascript", "typescript", "zig", "nim", "asm" },
              vim.bo.filetype
            )
        end,
      },
    })

    vim.keymap.set("n", "<leader>rb", function()
      overseer.run_template({ name = "build project" })
    end, { desc = "Build project" })
    vim.keymap.set("n", "<leader>rt", function()
      overseer.run_template({ name = "run tests" })
    end, { desc = "Run tests" })
    vim.keymap.set("n", "<leader>rr", function()
      overseer.run_template({ name = "run current file" })
    end, { desc = "Run current file" })
    vim.keymap.set("n", "<leader>rl", function()
      overseer.run_template({ name = "lint" })
    end, { desc = "Lint project" })
    vim.keymap.set("n", "<leader>rs", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer" })
    vim.keymap.set("n", "<leader>ro", "<cmd>OverseerRun<cr>", { desc = "Run task" })
    vim.keymap.set("n", "<leader>rq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick action" })
    vim.keymap.set("n", "<leader>ra", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })

    vim.keymap.set("n", "<leader>cc", "<cmd>copen<cr>", { desc = "Open quickfix" })
    vim.keymap.set("n", "<leader>cq", "<cmd>cclose<cr>", { desc = "Close quickfix" })
    vim.keymap.set("n", "<leader>cl", "<cmd>lopen<cr>", { desc = "Open loclist" })
    vim.keymap.set("n", "<leader>cL", "<cmd>lclose<cr>", { desc = "Close loclist" })
    vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
    vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
    vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })
    vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Prev loclist" })
  end,
}
