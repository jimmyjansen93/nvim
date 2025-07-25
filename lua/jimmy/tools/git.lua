return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup({
        graph_style = "unicode",
      })

      vim.keymap.set("n", "<leader>gg", "<CMD>Neogit<CR>", { desc = "Open git window" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({})

      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open diffview" })
      vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "File history" })
      vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current file history" })
    end,
  },
  {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      vim.g.git_worktree = {
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        confirm_telescope_deletions = true,
        autopush = false,
      }

      local Hooks = require("git-worktree.hooks")
      local config = require("git-worktree.config")
      local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

      Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
        vim.notify("Moved from " .. prev_path .. " to " .. path)
        update_on_switch(path, prev_path)
      end)

      Hooks.register(Hooks.type.DELETE, function()
        vim.cmd(config.update_on_change_command)
      end)

      local ok, _ = pcall(require("telescope").load_extension, "git_worktree")
      if not ok then
        vim.notify("Failed to load git_worktree telescope extension", vim.log.levels.WARN)
      end

      local function get_git_root()
        local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error ~= 0 then
          vim.notify("Not in a git repository", vim.log.levels.ERROR)
          return nil
        end
        return git_root
      end

      vim.keymap.set("n", "<leader>gw", function()
        local git_root = get_git_root()
        if git_root then
          require("telescope").extensions.git_worktree.git_worktree({ cwd = git_root })
        end
      end, { desc = "Switch worktree" })

      vim.keymap.set("n", "<leader>gW", function()
        local git_root = get_git_root()
        if git_root then
          local original_cwd = vim.fn.getcwd()
          vim.cmd("cd " .. git_root)

          local branch = vim.fn.input("Branch name: ")
          if branch ~= "" then
            local path = vim.fn.input("Worktree path: ", git_root .. "/" .. branch)
            if path ~= "" then
              local ok, err = pcall(require("git-worktree").create_worktree, path, branch)
              if not ok then
                vim.notify("Error creating worktree: " .. tostring(err), vim.log.levels.ERROR)
              end
            end
          end

          vim.cmd("cd " .. original_cwd)
        end
      end, { desc = "Create worktree" })

      vim.keymap.set("n", "<leader>gx", function()
        local git_root = get_git_root()
        if git_root then
          local original_cwd = vim.fn.getcwd()
          vim.cmd("cd " .. git_root)

          local worktrees_output = vim.fn.system("git worktree list --porcelain")
          local worktrees = {}
          local current_worktree = {}

          for line in worktrees_output:gmatch("[^\r\n]+") do
            if line:match("^worktree ") then
              if current_worktree.path then
                table.insert(worktrees, current_worktree)
              end
              current_worktree = { path = line:match("^worktree (.+)") }
            elseif line:match("^branch ") then
              current_worktree.branch = line:match("^branch refs/heads/(.+)")
            end
          end
          if current_worktree.path then
            table.insert(worktrees, current_worktree)
          end

          local deletable_worktrees = {}
          for _, wt in ipairs(worktrees) do
            if wt.path ~= git_root then
              table.insert(deletable_worktrees, wt)
            end
          end

          if #deletable_worktrees == 0 then
            vim.notify("No worktrees available to delete", vim.log.levels.INFO)
          else
            local choices = {}
            for i, wt in ipairs(deletable_worktrees) do
              table.insert(choices, i .. ". " .. (wt.branch or "detached") .. " -> " .. wt.path)
            end

            local choice = vim.fn.inputlist(vim.list_extend({ "Select worktree to delete:" }, choices))
            if choice > 0 and choice <= #deletable_worktrees then
              local selected = deletable_worktrees[choice]
              local confirm = vim.fn.input("Delete worktree '" .. selected.path .. "'? [y/N]: ")
              if confirm:lower() == "y" then
                local ok, err = pcall(require("git-worktree").delete_worktree, selected.path)
                if not ok then
                  vim.notify("Error deleting worktree: " .. tostring(err), vim.log.levels.ERROR)
                end
              end
            end
          end

          vim.cmd("cd " .. original_cwd)
        end
      end, { desc = "Delete worktree" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "±" },
        untracked = { text = "?" },
      },
      signs_staged = {
        add = { text = "◉" },
        change = { text = "◎" },
        delete = { text = "◌" },
        topdelete = { text = "◌" },
        changedelete = { text = "◎" },
        untracked = { text = "◉" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      sign_priority = 6,
    },
    keys = {
      { "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle blame" },
    },
  },
}
