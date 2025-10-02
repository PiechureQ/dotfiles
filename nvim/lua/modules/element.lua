local M = {}

local function log(msg)
  vim.notify('Element.lua: ' .. msg, vim.log.levels.INFO)
end
local function warn(msg)
  vim.notify('Element.lua: ' .. msg, vim.log.levels.WARN)
end
local function err(msg)
  vim.notify('Element.lua: ' .. msg, vim.log.levels.ERROR)
end

local opts = {
  command = 'element',
}

local function el_get_out_file(file)
  local rep, replaced = string.gsub(file, '%.ele', '.elo')
  if replaced == 0 then
    local start = string.find(file, '%.elo')
    if start == 0 then
      return file .. '.elo', 1
    else
      return file, 0
    end
  end
  return rep, 1
end
local function el_get_el_file(file)
  local rep, replaced = string.gsub(file, '%.elo', '.ele')
  if replaced == 0 then
    return '', 0
  end
  return rep, 1
end
local function el_get_matching_file(file)
  local el_file, found = el_get_el_file(file)
  if found == 0 then
    local out_file, found = el_get_out_file(file)
    if found == 0 then
      return out_file, 0
    else
      return out_file, 1
    end
  else
    return el_file, 1
  end
end
local function el_run_command(command, file)
  local out, found = el_get_out_file(file)
  if found == 0 then
    log 'nie kompatybilny plik'
    return nil
  end

  log('parsing ' .. file .. ' to ' .. out)
  local res = vim.system({ command, '-f', file, '-o', out }):wait()
  log('result ' .. res.code)
  if res.code ~= 0 then
    err(res.stderr)
  end
  return res
end

function M.run(name)
  local fn
  if M[name] then
    fn = M[name]
  end

  local file = vim.api.nvim_buf_get_name(0)
  if fn then
    fn(file)
  else
    warn('Brak komendy ' .. name)
  end
end

function M.parse(file)
  el_run_command(opts.command, file)
end

function M.toggle(file)
  M.parse(file)
  local matching, found = el_get_matching_file(file)
  log('Otwieram ' .. matching)
  vim.api.nvim_command('edit ' .. matching)
end

function M.report()
  local info = debug.getinfo(1, 'S')
  local full_path = info.source
  if full_path:sub(1, 1) == '@' then
    full_path = full_path:sub(2)
  end

  local directory_path = full_path:match '(.*[/\\])'
  if not directory_path then
    directory_path = ''
  end

  -- Złożenie nowej ścieżki
  local new_path = directory_path .. 'report.ele'
  vim.api.nvim_command('edit ' .. new_path)
end

function M.split(file)
  local matching, found = el_get_matching_file(file)
  if found == 0 then
    --
  end
  log('Otwieram w nowym oknie ' .. matching)
  vim.api.nvim_command('vsplit ' .. matching)
end

local function create_command()
  -- 🔹 rejestracja komendy :Convert
  vim.api.nvim_create_user_command('Element', function(o)
    M.run(o.args)
  end, {
    nargs = 1,
    complete = function(_, _, _)
      return { 'toggle', 'parse', 'split', 'report' }
    end,
  })
end

function M.setup()
  create_command()

  -- mapping
  vim.keymap.set('n', '<leader>l', [[:Element ]], { desc = 'Element ...' })
  vim.keymap.set('n', '<leader>le', [[:Element parse<cr>]], { desc = 'Element parse' })
  vim.keymap.set('n', '<leader>lt', [[:Element toggle<cr>]], { desc = 'Element toggle' })
  vim.keymap.set('n', '<leader>lv', [[:Element split<cr>]], { desc = 'Element open split' })
end

M.setup()

return M
