local ls = require('luasnip')
local s, i, c, t = ls.s, ls.insert_node, ls.choice_node, ls.text_node
local fmt = require('luasnip.extras.fmt').fmt;

ls.setup({
    history = true,
    update_events = { "TextChanged", "TextChangedI" },
    enable_autosnippets = false,
});

require("luasnip.loaders.from_vscode").lazy_load()

ls.add_snippets('typescript', {
    s('cl', fmt([[console.log({})]], { i(1) })),
    s('tsi', fmt([[// @ts-ignore: {}]], { i(1) })),
    s('TODO', fmt([[// {}: {}]], { c(1, { t "TODO", t "FIX" }), i(2) })),
})

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true });

vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true });

vim.keymap.set('i', '<M-r>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true });

vim.keymap.set('n', '\\s', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>');
