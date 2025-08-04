local overseer = require("overseer")

local function find_package_json()
  local current_dir = vim.fn.expand("%:p:h")
  while current_dir ~= "/" do
    if vim.uv.fs_stat(current_dir .. "/package.json") then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end
  return nil
end

local function get_package_manager(project_dir, package_json)
  if package_json.packageManager then
    local manager = package_json.packageManager:match("^([^@]+)")
    return manager
  end
  
  if package_json.engines and package_json.engines.pnpm then
    return "pnpm"
  elseif package_json.engines and package_json.engines.yarn then
    return "yarn"
  elseif package_json.engines and package_json.engines.bun then
    return "bun"
  end
  
  if vim.uv.fs_stat(project_dir .. "/pnpm-lock.yaml") then
    return "pnpm"
  elseif vim.uv.fs_stat(project_dir .. "/yarn.lock") then
    return "yarn"
  elseif vim.uv.fs_stat(project_dir .. "/bun.lockb") then
    return "bun"
  end
  
  return "npm"
end

local function register_package_json_templates()
  local project_dir = find_package_json()
  if not project_dir then
    return
  end

  local package_json = vim.fn.json_decode(vim.fn.readfile(project_dir .. "/package.json"))
  local scripts = package_json.scripts or {}
  local pkg_manager = get_package_manager(project_dir, package_json)
  
  for script_name, script_content in pairs(scripts) do
    local cmd = {}
    if script_name == "start" and pkg_manager == "npm" then
      cmd = { pkg_manager, "start" }
    else
      cmd = { pkg_manager, "run", script_name }
    end
    
    overseer.register_template({
      name = "js:" .. script_name,
      builder = function()
        return {
          cmd = cmd,
          cwd = project_dir,
          name = script_name .. " (" .. vim.fn.fnamemodify(project_dir, ":t") .. ")",
          components = { { "on_output_quickfix", open = true }, "default" },
        }
      end,
      condition = {
        filetype = "javascript",
      },
    })
  end
end

overseer.register_template({
  name = "javascript run current file",
  builder = function()
    local file = vim.fn.expand("%")
    return {
      cmd = { "node", file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = "javascript",
  },
})

register_package_json_templates()

vim.keymap.set("n", "<leader>rr", function()
  local project_dir = find_package_json()
  if project_dir then
    local package_json = vim.fn.json_decode(vim.fn.readfile(project_dir .. "/package.json"))
    local scripts = package_json.scripts or {}
    
    if vim.tbl_isempty(scripts) then
      vim.notify("No scripts found in package.json", vim.log.levels.WARN)
      return
    end

    local script_names = vim.tbl_keys(scripts)
    table.sort(script_names)
    
    if #script_names == 1 then
      overseer.run_template({ name = "js:" .. script_names[1] })
    else
      vim.ui.select(script_names, {
        prompt = "Select npm script:",
        format_item = function(script)
          return script .. " → " .. scripts[script]
        end,
      }, function(choice)
        if choice then
          overseer.run_template({ name = "js:" .. choice })
        end
      end)
    end
  else
    vim.notify("No package.json found", vim.log.levels.WARN)
  end
end, { buffer = true, desc = "Run npm script" })

vim.keymap.set("n", "<leader>rf", function()
  overseer.run_template({ name = "javascript run current file" })
end, { buffer = true, desc = "Run current JS file" })

vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2