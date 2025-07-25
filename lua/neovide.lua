if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font,Iosevka Nerd Font:h14"
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = "dark"
  vim.g.neovide_confirm_quit = false
  vim.g.neovide_detach_on_quit = "always_detach"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_smooth_blink = true

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.1)
  end)
  vim.keymap.set("c", "<C-v>", "<C-R>+", { desc = "Paste" })
end
