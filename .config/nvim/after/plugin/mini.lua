require('mini.bracketed').setup {
    treesitter = { suffix = 'r', options = {} },
    undo = { suffix = '', options = {} },
}
require('mini.visits').setup()
require('mini.cursorword').setup { delay = 1000 }
require('mini.icons').setup()
require('mini.trailspace').setup()
require('mini.surround').setup()
require('mini.splitjoin').setup()
