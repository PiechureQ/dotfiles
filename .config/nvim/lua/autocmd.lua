local A = vim.api

-- Custom filetypes
vim.filetype.add({
    extension = {
        eslintrc = 'json',
        prettierrc = 'json',
    },
    pattern = {
        ['.*%.env.*'] = 'sh',
        ['ignore$'] = 'conf',
    },
})

local group = A.nvim_create_augroup('user_commands', { clear = true })

-- highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual' })
    end,
})

-- return to last edit position when opening files
A.nvim_create_autocmd('BufReadPost', {
    group = group,
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
        if {row, col} ~= {0, 0} then
            vim.api.nvim_win_set_cursor(0, {row, 0})
        end
    end,
})
