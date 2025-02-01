local A = vim.api
local function cmd_out(cmd)
   return vim.api.nvim_cmd(vim.api.nvim_parse_cmd(cmd, {}), { output = true })
end

function CD()
   vim.cmd('cd %:p:h');
end

A.nvim_create_user_command('CD', CD, {})

function CDGit()
   local init_path = cmd_out 'pwd';
   CD()
   local git_path = cmd_out 'Git rev-parse --show-toplevel'
   if (string.find(git_path, 'fatal')) then
      vim.cmd('cd ' .. init_path);
   else
      vim.cmd('cd ' .. git_path);
   end
end

A.nvim_create_user_command('CDGit', CDGit, {})

-- edit and load config file
function OpenConfig()
   vim.cmd.tabe('$MYVIMRC')
   vim.cmd.CD()
end

A.nvim_create_user_command('OpenConfig', OpenConfig, {})
