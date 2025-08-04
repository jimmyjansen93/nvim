return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    winbar = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local function set_terminal_keymaps()
      local term_opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], term_opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], term_opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], term_opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
      on_close = function()
        vim.cmd("startinsert!")
      end,
    })

    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    local float_term = Terminal:new({
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    vim.keymap.set("n", "<leader>tf", function()
      float_term:toggle()
    end, { desc = "Floating terminal" })
    vim.keymap.set(
      "n",
      "<leader>th",
      "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
      { desc = "Horizontal terminal" }
    )
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical terminal" })
    vim.keymap.set("n", "<leader>tg", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })
    vim.keymap.set("n", "<leader>tn", function()
      node:toggle()
    end, { desc = "Node REPL" })
    vim.keymap.set("n", "<leader>tp", function()
      python:toggle()
    end, { desc = "Python REPL" })
    vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle all terminals" })
    vim.keymap.set("n", "<leader>tk", "<cmd>TermExec cmd='clear'<cr>", { desc = "Clear terminal" })
  end,
}
