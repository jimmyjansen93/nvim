return {
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      "leoluz/nvim-dap-go",
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
          "microsoft/vscode-js-debug",
          opts = {},
          run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        },
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>dt", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })

      dapui.setup({
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result." })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      require("dap-go").setup()
      require("dap-vscode-js").setup({
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.exepath("OpenDebugAD7") or "OpenDebugAD7",
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/gdb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
      }

      dap.configurations.cpp = dap.configurations.c

      dap.configurations.go = vim.list_extend(dap.configurations.go or {}, {
        {
          name = "Debug Package",
          type = "go",
          request = "launch",
          mode = "debug",
          program = "${workspaceFolder}",
        },
        {
          name = "Debug Test",
          type = "go",
          request = "launch",
          mode = "test",
          program = "${workspaceFolder}",
        },
        {
          name = "Attach to Process",
          type = "go",
          request = "attach",
          mode = "local",
          processId = function()
            return tonumber(vim.fn.input("Process ID: "))
          end,
        },
      })

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("codelldb") or "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.zig = {
        {
          name = "Launch Zig",
          type = "codelldb",
          request = "launch",
          program = function()
            local zigout = vim.fn.getcwd() .. "/zig-out/bin/"
            if vim.fn.isdirectory(zigout) == 1 then
              local files = vim.fn.globpath(zigout, "*", false, true)
              if #files > 0 then
                return files[1]
              end
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch Rust (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            local target_debug = vim.fn.getcwd() .. "/target/debug/"
            if vim.fn.isdirectory(target_debug) == 1 then
              local files = vim.fn.globpath(target_debug, "*", false, true)
              for _, file in ipairs(files) do
                if vim.fn.fnamemodify(file, ":e") == "" and vim.fn.executable(file) == 1 then
                  return file
                end
              end
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Launch Rust (release)",
          type = "codelldb",
          request = "launch",
          program = function()
            local target_release = vim.fn.getcwd() .. "/target/release/"
            if vim.fn.isdirectory(target_release) == 1 then
              local files = vim.fn.globpath(target_release, "*", false, true)
              for _, file in ipairs(files) do
                if vim.fn.fnamemodify(file, ":e") == "" and vim.fn.executable(file) == 1 then
                  return file
                end
              end
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/release/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
}
