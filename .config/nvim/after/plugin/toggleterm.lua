require("toggleterm").setup {
  -- size = 20 | function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  direction = "float",
  open_mapping = [[<C-,>]],
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  start_in_insert = true,
  persist_mode = false,
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = 'curved',
    -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
    -- width = function() vim.o.columns * 0.8 end,
    -- height = <value>,
    -- row = <value>,
    -- col = <value>,
    winblend = 3,
    -- zindex = <value>,
    title_pos = 'left'
  },
}

vim.keymap.set('t', "<esc><esc>", "<cmd>ToggleTerm<cr>")
vim.keymap.set('t', "<C-u>", [[<C-\><C-n><C-u>]])
vim.keymap.set('t', "<C-d>", [[<C-\><C-n><C-d>]])

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('n', '<esc>', "<cmd>ToggleTerm<cr>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
