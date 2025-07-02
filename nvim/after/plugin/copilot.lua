local config = require 'config'
local copilot_enabled = config.copilot_provider == 'copilot'

if copilot_enabled then
  require('copilot').setup {
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        accept = '<CR>',
        refresh = 'gr',
        open = '<M-CR>',
      },
      layout = {
        position = 'right', -- | top | left | right
        ratio = 0.3,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = '<M-l>',
        accept_word = false,
        accept_line = '<M-i>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ['.'] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 16.x
    server_opts_overrides = {},
  }

  vim.keymap.set('n', '<leader>tc', ':Copilot toggle<CR>', { desc = '[T]oggle [C]opilot' })
  vim.keymap.set('n', '<leader>tp', ':Copilot panel<CR>', { desc = '[T]oggle copilot [P]anel' })
end
