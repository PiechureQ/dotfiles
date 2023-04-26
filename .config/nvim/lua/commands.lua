local A = vim.api

function CD()
   vim.cmd('cd %:p:h');
end

A.nvim_create_user_command('CD', CD, {})

-- edit and load config file
function OpenConfig()
   vim.cmd.tabe('$MYVIMRC')
   vim.cmd.CD()
end
A.nvim_create_user_command('OpenConfig', OpenConfig, {})
