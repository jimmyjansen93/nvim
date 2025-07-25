return {
  {
    "LintaoAmons/cd-project.nvim",
    config = function()
      require("cd-project").setup({
        projects_config_filepath = vim.fn.stdpath("config") .. "/projects.json",
        project_dir_pattern = {
          ".git",
          ".svn",
          "Cargo.toml",
          "package.json",
          "go.mod",
          "build.zig",
          "pyproject.toml",
          "pom.xml",
        },
        choice_format = "both",
        projects_picker = "telescope",
        auto_register_project = false,
      })

      vim.keymap.set("n", "<leader>pp", "<cmd>CdProject<cr>", { desc = "Switch to project" })
      vim.keymap.set("n", "<leader>pa", "<cmd>CdProjectAdd<cr>", { desc = "Add current to projects" })
      vim.keymap.set("n", "<leader>pf", function()
        require("telescope.builtin").find_files({
          cwd = require("cd-project").get_project_root(),
        })
      end, { desc = "Find files in project" })
    end,
  },
}
