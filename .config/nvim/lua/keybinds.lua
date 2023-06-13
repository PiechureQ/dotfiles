local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- Keymaps for better default experience
vim.keymap.set("n", "Q", "<Nop>", { silent = true })
vim.keymap.set("n", "q", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "J", "<Nop>", { silent = true })

-- so current file
vim.keymap.set("n", "<leader>so", ":source %<cr>", { silent = true, desc = "source current config file" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quit, save
vim.keymap.set("n", "<leader>q", ":q<cr>", { silent = true, desc = "Close window" })
vim.keymap.set("", "<c-s>", ":w<cr>", { silent = true, desc = "Write to buffer" })
vim.keymap.set("i", "<c-s>", "<c-o>:w<cr>", { silent = true, desc = "Write to buffer" })

-- open Explore https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
-- vim.keymap.set("n", "<leader>N", function()
--     vim.cmd.Lexplore()
-- end, { desc = "Open netrw in current directory" })

-- vim.keymap.set("n", "<leader>n", function()
--     local cwd = vim.fn.expand("%:h")
--     local ft = vim.bo.filetype
--     if cwd == "" or ft == "netrw" then
--         vim.cmd.Lexplore()
--     else
--         vim.cmd.Lexplore(cwd)
--     end
-- end, { desc = "Open netrw" })

-- delete word OS style
vim.keymap.set("!", "<c-BS>", "<c-w>", {})

-- yank and paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank with system clipbord" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Put from system clipbord before the cursor" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Put from system clipbord after the cursor" })
vim.keymap.set({ "i", "c" }, "<C-v>", "<C-r>+")
vim.keymap.set({ "i", "c" }, "<C-r><C-r>", [[<C-r>"]])

-- paste won't yank in normal
vim.keymap.set("x", "p", '"_dP', {})

-- move highlighted text
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- easier window hor/ver maximize
vim.keymap.set("", "<C-w>M", "<C-w>|", { desc = "Max out the width" })
vim.keymap.set("", "<C-w>m", "<C-w>_", { desc = "Max out the height" })

-- move between tabs
vim.keymap.set("", "[t", "gT", {})
vim.keymap.set("", "]t", "gt", {})

vim.keymap.set("n", "<leader>tn", ":tabnew<cr>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>to", ":tabonly<cr>", { desc = "Close other tabs" })
-- tabs
vim.keymap.set("n", "<leader>tH", ":tabmove - <cr>", { desc = "Move tab to the left" })
vim.keymap.set("n", "<leader>tL", ":tabmove + <cr>", { desc = "Move tab to the right" })
vim.keymap.set("n", "<leader>tr", ":.+1,$tabdo :q <cr>", { desc = "close all tabs the right" })
vim.keymap.set("n", "<leader>tR", ":.-1,1tabdo :q <cr>", { desc = "close all tabs the left" })

-- move to start/end of the line
vim.keymap.set("n", "H", "0", { noremap = true })
vim.keymap.set("n", "L", "g_", { noremap = true })

-- search/replace visually selected text
vim.keymap.set("v", "//", "y/<C-R>=escape(@\",'/')<CR><CR>", { desc = "Search selected text" })
vim.keymap.set("v", "??", "y:%s/<C-R>=escape(@\",'/')<CR>/", { desc = "Search and replace selected text" })
vim.keymap.set("v", "<leader>s", "y:%s/<C-R>=escape(@\",'/')<CR>/", { desc = "Search and replace selected text" })
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search and replace word under cursor text" }
)

-- clear highlights
vim.keymap.set("", "<leader><Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear visual highlights" })

-- quickfix/locationlist mapings
vim.keymap.set("n", "<leader>J", vim.cmd.lnext, { desc = "Location list next item" })
vim.keymap.set("n", "<leader>K", vim.cmd.lprevious, { desc = "Location list previous item" })
vim.keymap.set("n", "<leader>L", vim.cmd.lopen, { desc = "Open location list" })

vim.keymap.set("n", "<leader>j", vim.cmd.cnext, { desc = "Quickfix list next item" })
vim.keymap.set("n", "<leader>k", vim.cmd.cprevious, { desc = "Quickfix list previous item" })
vim.keymap.set("n", "<leader>c", vim.cmd.copen, { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>cc", vim.cmd.cclose, { desc = "Close quickfix list" })
