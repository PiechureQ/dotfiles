-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- END_DEFAULT_ON_ATTACH
    api.config.mappings.default_on_attach(bufnr)

    -- remove a default
    -- vim.keymap.del('n', '-', { buffer = bufnr })
    -- vim.keymap.del('n', 's', { buffer = bufnr })

    -- add your mappings
    -- vim.keymap.set('n', '-', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '{', api.tree.change_root_to_parent, opts('CD to Parent'))
    vim.keymap.set('n', '}', api.tree.change_root_to_node, opts('CD to Node'))
    vim.keymap.set('n', '<C-[>', api.tree.close, opts('Close Tree'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
end

require("nvim-tree").setup({
    on_attach = on_attach,
    view = {
        side = "right",
        signcolumn = "no",
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
})

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })

-- vim.keymap.set("n", "-", ":NvimTreeFindFile!<CR>", { silent = true, desc = "Open active file in NvimTree" })
