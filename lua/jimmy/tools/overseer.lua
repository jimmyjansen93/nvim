return {
  "stevearc/overseer.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  keys = {
    { "<leader>rb", desc = "Build project" },
    { "<leader>rt", desc = "Run tests" },
    { "<leader>rr", desc = "Run project" },
    { "<leader>rf", desc = "Run current file" },
    { "<leader>rl", desc = "Lint project" },
    { "<leader>rs", desc = "Toggle overseer" },
    { "<leader>ro", desc = "Run task" },
    { "<leader>rq", desc = "Quick action" },
    { "<leader>ra", desc = "Task action" },
  },
  opts = {
    templates = { "builtin" },
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

    vim.keymap.set("n", "<leader>rs", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer" })
    vim.keymap.set("n", "<leader>ro", "<cmd>OverseerRun<cr>", { desc = "Run task" })
    vim.keymap.set("n", "<leader>rq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick action" })
    vim.keymap.set("n", "<leader>ra", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })

    vim.keymap.set("n", "<leader>cq", "<cmd>copen<cr>", { desc = "Open quickfix" })
    vim.keymap.set("n", "<leader>cQ", "<cmd>cclose<cr>", { desc = "Close quickfix" })
    vim.keymap.set("n", "<leader>cL", "<cmd>lopen<cr>", { desc = "Open loclist" })
    vim.keymap.set("n", "<leader>cM", "<cmd>lclose<cr>", { desc = "Close loclist" })
    vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
    vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
    vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })
    vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Prev loclist" })
  end,
}

