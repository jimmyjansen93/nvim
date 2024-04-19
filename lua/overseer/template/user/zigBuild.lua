return {
  name = 'zigBuild',
  builder = function()
    return {
      cmd = { 'zig', 'build' },
      components = {
        { 'on_output_quickfix', open = true },
        'default',
        -- 'on_result_diagnostics',
      },
    }
  end,
  condition = {
    filetype = { 'zig' },
  },
}
