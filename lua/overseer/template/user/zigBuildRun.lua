return {
  name = 'zigBuildRun',
  builder = function()
    return {
      cmd = { 'zig', 'build', 'run' },
      components = {
        {
          'on_output_quickfix',
          open = true,
          close = true,
          open_on_exit = 'failure',
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
