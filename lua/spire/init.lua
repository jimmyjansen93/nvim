local m = {}

function m.list_dir(dir, filter)
  local files = { '.', '..' }
  local handle = vim.loop.fs_scandir(dir)
  if handle then
    while true do
      local name, _ = vim.loop.fs_scandir_next(handle)
      if not name then
        break
      end
      if filter == nil or filter == '' or name:find(filter) then
        table.insert(files, name)
      end
    end
  end
  return files
end

function m.update_buffer(buffer, cwd, filter)
  local file_list = m.list_dir(cwd, filter)
  local buffer_content = { cwd }
  for _, file in ipairs(file_list) do
    table.insert(buffer_content, file)
  end
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_content)
end

function m.init_selection(buf)
  vim.api.nvim_buf_set_var(buf, 'current_selection', 1)
end

function m.highlight_selection(buf, index) end

function m.update_selection(buf, direction)
  local current_selection = vim.api.nvim_buf_get_var(buf, 'current_selection')
  local line_count = vim.api.nvim_buf_line_count(buf)
  if direction == 'next' then
    current_selection = math.min(current_selection + 1, line_count - 1)
  elseif direction == 'prev' then
    current_selection = math.max(current_selection - 1, 2)
  end
  vim.api.nvim_buf_set_var(buf, 'current_selection', current_selection)
  m.highlight_selection(buf, current_selection)
end

function m.open_or_navigate_selection(buf)
  local current_selection = vim.api.nvim_buf_get_var(buf, 'current_selection')
  local lines = vim.api.nvim_buf_get_lines(buf, current_selection, current_selection + 1, false)
  local selection = lines[1]

  if selection == '.' then
  elseif selection == '..' then
    local cwd = vim.fn.getcwd()
    local parent_dir = vim.fn.fnamemodify(cwd, ':h')
    vim.fn.chdir(parent_dir)
    m.update_buffer(buf, parent_dir, '')
    m.init_selection(buf)
  else
    local new_path = vim.fn.getcwd() .. '/' .. selection
    if vim.fn.isdirectory(new_path) == 1 then
      vim.fn.chdir(new_path)
      m.update_buffer(buf, new_path, '')
      m.init_selection(buf)
    else
      vim.cmd('edit' .. new_path)
    end
  end
end

function m.on_backspace(buf)
  if input_is_empty then
    local cwd = vim.fn.getcwd()
    local parent_dir = vim.fn.fnamemodify(cwd, ':h')
    vim.fn.chdir(parent_dir)
    m.update_buffer(buf, parent_dir, '')
    m.init_selection(buf)
  end
end

function m.on_char() end

function m.open_spire_window()
  local win_height = vim.api.nvim_get_option_value('lines', {}) * 0.2
  local win_width = vim.api.nvim_get_option_value('columns', {})

  local buf = vim.api.nvim_create_buf(false, true)

  local opts = {
    relative = 'editor',
    width = win_width,
    height = math.floor(win_height),
    row = vim.api.nvim_get_option_value('lines', {}) - math.floor(win_height),
    col = 0,
    style = 'minimal',
    border = 'single',
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })

  vim.api.nvim_set_option_value('number', false, { win = win })
  vim.api.nvim_set_option_value('relativenumber', false, { win = win })

  m.update_buffer(buf, vim.fn.getcwd(), '')

  vim.api.nvim_buf_set_keymap(buf, 'i', '<char>', 'lua require("spire").on_char()', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'i', '<BS>', 'lua require("spire").on_backspace()', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<C-n>', 'lua require("spire").update_selection(vim.fn.bufnr("%"), 'next')', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<C-p>', 'lua require("spire").update_selection(vim.fn.bufnr("%"), 'prev')', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', 'lua require("spire").open_or_navigate_selection(vim.fn.bufnr("%"))', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Tab>', 'lua require("spire").open_or_navigate_selection(vim.fn.bufnr("%"))', { noremap = true, silent = true })
end

return m
