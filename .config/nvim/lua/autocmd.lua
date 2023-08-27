-- Custom filetypes
-- vim.filetype.add({
--     extension = {
--         eslintrc = "json",
--         prettierrc = "json",
--     },
--     pattern = {
--         [".*%.env.*"] = "sh",
--         ["ignore$"] = "conf",
--     },
-- })

-- highlight the region on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

