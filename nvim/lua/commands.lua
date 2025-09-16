local A = vim.api

A.nvim_create_user_command('Wa', vim.cmd 'wa', {})
A.nvim_create_user_command('WA', vim.cmd 'wa', {})

local function cmd_out(cmd)
  return vim.api.nvim_cmd(vim.api.nvim_parse_cmd(cmd, {}), { output = true })
end

function CD()
  vim.cmd 'cd %:p:h'
end

A.nvim_create_user_command('CD', CD, {})

function CDGit()
  local init_path = cmd_out 'pwd'
  CD()
  local git_path = cmd_out 'Git rev-parse --show-toplevel'
  if string.find(git_path, 'fatal') then
    vim.cmd('cd ' .. init_path)
  else
    vim.cmd('cd ' .. git_path)
  end
end

A.nvim_create_user_command('CDGit', CDGit, {})

-- edit and load config file
function OpenConfig()
  vim.cmd.tabe '$MYVIMRC'
  vim.cmd.CD()
end

A.nvim_create_user_command('OpenConfig', OpenConfig, {})

vim.api.nvim_create_user_command('VerboseMapToBuffer', function()
  local output = vim.api.nvim_exec('verbose map', { return_string = true })
  local lines = vim.split(output, '\n')
  vim.api.nvim_command 'new'
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end, { desc = 'Show verbose map in a new buffer' })
