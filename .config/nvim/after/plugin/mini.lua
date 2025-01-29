-- edit
require('mini.ai').setup();
require('mini.operators').setup();
require('mini.splitjoin').setup()
require('mini.surround').setup()
require('mini.bracketed').setup {
    treesitter = { suffix = 'r', options = {} },
    undo = { suffix = '', options = {} },
}
require('mini.jump2d').setup();

-- functional
require('mini.files').setup()

require('mini.notify').setup();

-- visual
require('mini.cursorword').setup { delay = 1000 }
require('mini.trailspace').setup()
require('mini.icons').setup()

local minifiles_toggle = function()
    if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end
vim.keymap.set('n', '-', minifiles_toggle, { desc = 'Open files' })
