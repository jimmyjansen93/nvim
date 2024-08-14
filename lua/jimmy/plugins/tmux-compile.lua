return {
  {
    'karshPrime/tmux-compile.nvim',
    event = 'VeryLazy',
    config = function()
      require('tmux-compile').setup {
        -- Overriding Default Configurations. [OPTIONAL]
        save_session = false, -- Save file before action (:wall)
        build_run_window_title = 'build', -- Tmux window name for Build/Run
        ---- same window pane
        new_pane_everytime = false, -- Use existing side panes for action, when false
        side_width_percent = 50, -- Side pane width percentage
        bottom_height_percent = 30, -- Bottom pane height percentage
        ---- overlay window
        overlay_width_percent = 80, -- Overlay width percentage
        overlay_height_percent = 80, -- Overlay height percentage
        overlay_sleep = 1, -- Pause before overlay autoclose; seconds
        -- By default it sets value to -1,
        -- indicating not to autoclose overlay

        -- Languages' Run and Build actions.  [REQUIRED]
        build_run_config = {
          {
            extension = { 'c', 'cpp', 'h' },
            build = 'make',
            run = 'make run',
            debug = 'lldb',
          },
          {
            extension = { 'rs' },
            build = 'cargo build',
            run = 'cargo run',
            debug = 'cargo test',
          },
          {
            extension = { 'go' },
            run = 'go run .',
            build = 'go build .',
            debug = 'go test',
          },
          {
            extension = { 'zig' },
            run = 'zig run .',
            build = 'zig build .',
            debug = 'zig test .',
          },
        },
      }

      vim.keymap.set('n', '<leader>rr', ':TMUXcompile Run<CR>', { silent = true, desc = 'Run in Tmux' })
      vim.keymap.set('n', '<F3>', ':TMUXcompile BuildBG<CR>', { silent = true, desc = 'Build in Tmux' })
      vim.keymap.set('n', '<F4>', ':TMUXcompile RunBG<CR>', { silent = true, desc = 'Run in Tmux' })
      vim.keymap.set('n', '<F5>', ':TMUXcompile DebugBG<CR>', { silent = true, desc = 'Debug in Tmux' })
    end,
  },
}
