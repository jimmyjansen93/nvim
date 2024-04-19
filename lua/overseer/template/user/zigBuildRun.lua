return {
  name = 'zigBuildRun',
  builder = function()
    return {
      cmd = { 'zig', 'build', 'run' },
      components = {
        { 'on_output_quickfix', open = true },
        'on_result_diagnostics',
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'zig' },
  },
}
