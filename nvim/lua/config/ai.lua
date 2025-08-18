local M = {}
local TermTogglePlugin = {}

function TermTogglePlugin.setup(cmd)
  local term_win

  local function toggle()
    if not term_win then
      local Terminal = require('toggleterm.terminal').Terminal
      term_win = Terminal:new {
        cmd = cmd,
        dir = vim.fn.getcwd(),
        hidden = true,
        direction = 'vertical',
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
          -- vim.api.nvim_buf_set_keymap(term.bufnr, { 'n', 't' }, '<leader>q', term.toggle(), { desc = 'Toggle terminal' })
          -- vim.api.nvim_buf_set_keymap(term.bufnr, { 'n', 't' }, '<leader>q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
      }
    end
    term_win:toggle()
  end

  return toggle
end

function M.setup()
  local term_gemini = TermTogglePlugin.setup 'gemini'
  local term_opencode = TermTogglePlugin.setup 'opencode'

  vim.keymap.set('n', '<leader>mg', term_gemini, { noremap = true, silent = true, desc = 'Toggle Gemini CLI' })
  vim.keymap.set('n', '<leader>mp', term_opencode, { noremap = true, silent = true, desc = 'Toggle OpenCode AI CLI' })
end

return M
