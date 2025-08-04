return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("data") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
        pre_save = function()
          vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
        end,
        save_empty = false,
      })

      local function restore_session()
        require("persistence").load()
        vim.notify("Session restored", vim.log.levels.INFO)
      end

      local function restore_last_session()
        require("persistence").load({ last = true })
        vim.notify("Last session restored", vim.log.levels.INFO)
      end

      local function save_session()
        require("persistence").save()
        vim.notify("Session saved", vim.log.levels.INFO)
      end

      local function delete_session()
        require("persistence").stop()
        vim.notify("Session auto-save disabled", vim.log.levels.WARN)
      end

      local auto_save_timer = vim.uv.new_timer()
      if auto_save_timer then
        auto_save_timer:start(
          300000,
          300000,
          vim.schedule_wrap(function()
            if vim.v.this_session ~= "" then
              require("persistence").save()
            end
          end)
        )
      end

      vim.keymap.set("n", "<leader>nS", save_session, { desc = "Save session" })
      vim.keymap.set("n", "<leader>ns", restore_session, { desc = "Restore session" })
      vim.keymap.set("n", "<leader>nl", restore_last_session, { desc = "Restore last session" })
      vim.keymap.set("n", "<leader>nd", delete_session, { desc = "Delete session" })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          local buffers = vim.api.nvim_list_bufs()
          local has_real_buffers = false

          for _, buf in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
              local buftype = vim.bo[buf].buftype
              if buftype == "" then
                has_real_buffers = true
                break
              end
            end
          end

          if has_real_buffers then
            require("persistence").save()
          end
        end,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc(-1) == 0 then
            vim.defer_fn(function()
              local sessions_dir = vim.fn.stdpath("data") .. "/sessions/"
              local current_dir_session = sessions_dir .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"

              if vim.uv.fs_stat(current_dir_session) then
                restore_session()
              else
                local sessions_exist = vim.fn.glob(sessions_dir .. "*") ~= ""
                if sessions_exist then
                  vim.ui.select({ "Yes", "No" }, {
                    prompt = "No session for current directory. Restore last session?",
                  }, function(choice)
                    if choice == "Yes" then
                      restore_last_session()
                    end
                  end)
                end
              end
            end, 100)
          end
        end,
        nested = true,
      })
    end,
  },
  {
    "DrKJeff16/project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VimEnter",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "Cargo.toml",
          "go.mod",
          "build.zig",
        },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })

      require("telescope").load_extension("projects")

      local function switch_project()
        require("telescope").extensions.projects.projects({})
      end

      local function add_project()
        local current_dir = vim.fn.getcwd()
        require("project_nvim.project").set_pwd(current_dir, "manual")
        vim.notify("Added current directory as project: " .. current_dir, vim.log.levels.INFO)
      end

      vim.keymap.set("n", "<leader>pP", switch_project, { desc = "Switch project" })
      vim.keymap.set("n", "<leader>pa", add_project, { desc = "Add current dir as project" })
      vim.keymap.set("n", "<leader>pr", function()
        vim.cmd("cd " .. require("project_nvim.project").get_project_root())
        vim.notify("Changed to project root: " .. vim.fn.getcwd(), vim.log.levels.INFO)
      end, { desc = "Go to project root" })

      local project_augroup = vim.api.nvim_create_augroup("ProjectConfig", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "ProjectChanged",
        group = project_augroup,
        callback = function(ev)
          local project_name = vim.fn.fnamemodify(ev.data, ":t")
          vim.notify("Switched to project: " .. project_name, vim.log.levels.INFO)

          if _G.ProblemsModule then
            _G.ProblemsModule.problems = {}
          end
        end,
      })
    end,
  },
}
