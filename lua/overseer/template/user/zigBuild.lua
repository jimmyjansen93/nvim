return {
  name = 'zigBuild',
  builder = function()
    return {
      cmd = { 'zig', 'build' },
      components = {
        {
          'on_output_quickfix',
          open = false,
          close = true,
          open_on_exit = 'never',
          tail = false,
        },
        'on_result_diagnostics',
        'restart_on_save',
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'zig' },
  },
}