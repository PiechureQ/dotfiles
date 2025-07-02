local M = {}

function M.setup()
  local gemini_term

  function _G.toggle_gemini()
    if not gemini_term then
      local Terminal = require('toggleterm.terminal').Terminal
      gemini_term = Terminal:new {
        cmd = 'gemini',
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
    gemini_term:toggle()
  end

  vim.api.nvim_set_keymap('n', '<leader>mp', '<cmd>lua _G.toggle_gemini()<CR>', { noremap = true, silent = true, desc = 'Toggle Gemini CLI' })
end

return M
