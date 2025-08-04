return {
  "ludovicchabant/vim-gutentags",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.g.gutentags_modules = { "gtags_cscope" }

    vim.g.gutentags_file_list_command = {
      markers = {
        [".git"] = "git ls-files",
        [".hg"] = "hg files",
      },
    }

    vim.g.gutentags_ctags_tagfile = "tags"
    vim.g.gutentags_gtags_dbpath = vim.fn.stdpath("cache") .. "/gtags"
    vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/gtags"

    vim.g.gutentags_generate_on_missing = 0
    vim.g.gutentags_generate_on_write = 0
    vim.g.gutentags_generate_on_new = 0

    vim.g.gutentags_ctags_exclude = {
      "*.git",
      "*.svg",
      "*.hg",
      "*/tests/*",
      "build",
      "dist",
      "*sites/*/files/*",
      "bin",
      "node_modules",
      "bower_components",
      "cache",
      "compiled",
      "docs",
      "example",
      "bundle",
      "vendor",
      "*.md",
      "*.css",
      "*.less",
      "*.scss",
      "*.exe",
      "*.dll",
      "*.mp3",
      "*.ogg",
      "*.flac",
      "*.swp",
      "*.swo",
      "*.bmp",
      "*.gif",
      "*.ico",
      "*.jpg",
      "*.png",
      "*.rar",
      "*.zip",
      "*.tar",
      "*.tar.gz",
      "*.tar.xz",
      "*.tar.bz2",
      "*.pdf",
      "*.doc",
      "*.docx",
      "*.ppt",
      "*.pptx",
    }

    local function is_large_project()
      local cwd = vim.fn.getcwd()
      local result = vim.fn.system(
        "find "
          .. vim.fn.shellescape(cwd)
          .. " -type f -name '*.lua' -o -name '*.js' -o -name '*.ts' -o -name '*.jsx' -o -name '*.tsx' -o -name '*.py' -o -name '*.go' -o -name '*.rs' -o -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' -o -name '*.zig' "
          .. "| grep -v node_modules | grep -v dist | grep -v build | grep -v .git | wc -l"
      )
      local file_count = tonumber(result:gsub("%s+", ""))

      return (file_count and file_count > 1000)
        or vim.uv.fs_stat(cwd .. "/node_modules")
        or vim.uv.fs_stat(cwd .. "/packages")
        or vim.uv.fs_stat(cwd .. "/apps")
    end

    local function get_git_head_hash()
      local result = vim.fn.system("cd " .. vim.fn.getcwd() .. " && git rev-parse HEAD 2>/dev/null")
      if vim.v.shell_error == 0 then
        return result:gsub("%s+", "")
      end
      return nil
    end

    local function get_modified_files_since_gtags()
      local cwd = vim.fn.getcwd()
      local gtags_file = cwd .. "/GTAGS"
      local gtags_stat = vim.uv.fs_stat(gtags_file)

      if not gtags_stat then
        return {}
      end

      local result = vim.fn.system(
        "find "
          .. vim.fn.shellescape(cwd)
          .. " -type f -newer "
          .. vim.fn.shellescape(gtags_file)
          .. " \\( -name '*.lua' -o -name '*.js' -o -name '*.ts' -o -name '*.jsx' -o -name '*.tsx' -o -name '*.py' -o -name '*.go' -o -name '*.rs' -o -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' -o -name '*.zig' \\) "
          .. "| grep -v node_modules | grep -v dist | grep -v build | grep -v .git"
      )

      if vim.v.shell_error == 0 and result ~= "" then
        local files = {}
        for file in result:gmatch("[^\n]+") do
          table.insert(files, file)
        end
        return files
      end
      return {}
    end

    local function get_update_strategy()
      local cwd = vim.fn.getcwd()
      local gtags_file = cwd .. "/GTAGS"
      local gtags_stat = vim.uv.fs_stat(gtags_file)

      if not gtags_stat then
        return "full_regen", "GTAGS database missing"
      end

      local git_head_file = cwd .. "/.git/refs/heads"
      local git_head_stat = vim.uv.fs_stat(git_head_file)
      if git_head_stat and git_head_stat.mtime.sec > gtags_stat.mtime.sec then
        return "full_regen", "Git HEAD changed"
      end

      local modified_files = get_modified_files_since_gtags()
      if #modified_files == 0 then
        return "none", "GTAGS up-to-date"
      elseif #modified_files == 1 and modified_files[1] == vim.fn.expand("%:p") then
        return "single_file", "Current file modified"
      elseif #modified_files <= 5 then
        return "incremental", #modified_files .. " files modified"
      else
        return "full_regen", #modified_files .. " files modified"
      end
    end

    local function execute_update_strategy(strategy, reason)
      local cwd = vim.fn.getcwd()
      local is_large = is_large_project()

      if strategy == "none" then
        return
      elseif strategy == "single_file" then
        local current_file = vim.fn.expand("%:p")
        vim.fn.system("cd " .. cwd .. " && global --single-update=" .. vim.fn.shellescape(current_file))
      elseif strategy == "incremental" then
        vim.fn.system("cd " .. cwd .. " && global -u")
      elseif strategy == "full_regen" then
        if is_large then
          print("Regenerating gtags database...")
        end
        vim.fn.system("cd " .. cwd .. " && gtags")
        if is_large then
          print("Gtags updated")
        end
      end
    end

    local function smart_gtags_update()
      local strategy, reason = get_update_strategy()
      execute_update_strategy(strategy, reason)
    end

    local function generate_gtags()
      local cwd = vim.fn.getcwd()
      vim.fn.system("cd " .. cwd .. " && gtags")
      print("Generated new gtags database")
    end

    local function gtags_find_definition()
      local word = vim.fn.expand("<cword>")
      local result = vim.fn.system("global -x " .. vim.fn.shellescape(word))
      if vim.v.shell_error == 0 and result ~= "" then
        vim.cmd("cexpr " .. vim.fn.string(result))
        vim.cmd("copen")
      else
        print("No definition found for: " .. word)
      end
    end

    local function gtags_find_references()
      local word = vim.fn.expand("<cword>")
      local result = vim.fn.system("global -rx " .. vim.fn.shellescape(word))
      if vim.v.shell_error == 0 and result ~= "" then
        vim.cmd("cexpr " .. vim.fn.string(result))
        vim.cmd("copen")
      else
        print("No references found for: " .. word)
      end
    end

    vim.keymap.set("n", "gD", gtags_find_definition, { desc = "Gtags: Find definition" })
    vim.keymap.set("n", "gR", gtags_find_references, { desc = "Gtags: Find references" })
    vim.keymap.set("n", "<leader>cgg", generate_gtags, { desc = "Generate gtags" })

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        local cwd = vim.fn.getcwd()
        if vim.uv.fs_stat(cwd .. "/.git") then
          smart_gtags_update()
        end
      end,
      desc = "Smart gtags update on file save",
    })
  end,
}

