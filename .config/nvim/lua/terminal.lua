vim.keymap.set('n', '<leader>tt', ':vsplit<cr>:term<cr>', { desc = 'toggle terminal' })
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n><C-w>q', { desc = 'escape terminal' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'escape terminal' })
