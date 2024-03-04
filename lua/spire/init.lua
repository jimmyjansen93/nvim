local M = {}

function M.open_spire_window()
    local win_height = vim.api.nvim_get_option_value("lines", {}) * 0.2
    local win_width = vim.api.nvim_get_option_value("columns", {})

    local buf = vim.api.nvim_create_buf(false, true)

    local opts = {
        relative = "editor",
        width = win_width,
        height = math.floor(win_height),
        row = vim.api.nvim_get_option_value("lines", {}) - math.floor(win_height),
        col = 0,
        style = "minimal",
        border = "single",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

    vim.api.nvim_set_option_value("number", false, { win = win })
    vim.api.nvim_set_option_value("relativenumber", false, { win = win })
end

return M
