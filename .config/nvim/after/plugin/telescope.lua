local telescope = require("telescope")
local builtin = require("telescope.builtin")
local frecency = require("frecency")

frecency.setup {
    hide_current_buffer = true,
    preceding = 'opened',
    show_unindexed = false,
}

local default_layout_strategy = "horizontal"
local dropdown_theme = require("telescope.themes").get_dropdown({
    prompt_position = "top",
    previewer = false,
})

local nmap = function(key, action, desc)
    vim.keymap.set("n", key, action, { noremap = true, silent = true, nowait = true, desc = desc })
end

-- most important
nmap("<leader><leader>", builtin.resume, "Resume telescope")
nmap("<leader>fp", builtin.diagnostics, "Search diagnostics")
nmap("<leader>fi", builtin.find_files, "Find files")
nmap("<leader>fI", function()
    builtin.find_files({ cwd = vim.fn.expand('%:h') })
end, "Find files (in current buf path)")

nmap("<leader>?", builtin.oldfiles, "Find recently opened files")
nmap("<leader>/", function()
    builtin.current_buffer_fuzzy_find(dropdown_theme)
end, "Fuzzily search in current buffer]")

nmap("<leader>ff", builtin.live_grep, "live grep")
nmap("<leader>fw", builtin.grep_string, "find word under cursor")
nmap("<leader>ft", builtin.git_status, "git status")

nmap("<leader>fd", function()
    builtin.grep_string({
        search = vim.fn.input("grep: "),
        layout_strategy = default_layout_strategy,
    })
end, "search word")

-- others
nmap("<leader>fr", builtin.builtin, "Telescope builtin")
nmap("<leader>fm", builtin.marks, "Search marks")
nmap("<leader>fb", builtin.buffers, "Search buffer")
nmap("<leader>fh", builtin.help_tags, "Search tags")
nmap("<leader>fg", builtin.git_branches, "Search branches")
nmap("<leader>fc", builtin.git_commits, "Search commits")
nmap("<leader>fj", builtin.jumplist, "Search jump list")
nmap("<leader>fO", frecency.start, "Search old files")
nmap("<leader>fo", function()
    vim.cmd [[Telescope frecency default_text=:CWD:]]
end, "Search old files (CWD)")
nmap("<leader>fs", builtin.lsp_dynamic_workspace_symbols, "Search workspace symbols")

telescope.setup({
    defaults = {
        layout_strategy = default_layout_strategy,
        layout_config = {
            center = {
                prompt_position = "top",
            },
            horizontal = {
                preview_width = .66,
            },
            vertical = {
                height = 0.95,
                width = 0.8,
                preview_cutoff = 10,
            },
            cursor = {
                height = 0.4,
                preview_cutoff = 10,
                width = 0.7,
            },
        },
        scroll_strategy = "limit",
        path_display = { "absolute", "smart" },
        dynamic_preview_title = true,
        winblend = 0,
        mappings = {
            i = {
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
            n = {
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
            },
        },
    },
    pickers = {
        oldfiles = {
            cwd_only = true,
        },
        grep_string = {
            layout_strategy = "cursor",
        },
        lsp_definitions = {
            layout_strategy = "cursor",
            jump_type = "vsplit",
            mappings = {
                i = {
                    ["<CR>"] = "file_vsplit",
                },
                n = {
                    ["<CR>"] = "file_vsplit",
                },
            },
        },
        lsp_references = {
            include_declaration = false,
            include_current_line = true,
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

telescope.load_extension("fzy_native")
telescope.load_extension("emoji")
telescope.load_extension("luasnip")
telescope.load_extension("frecency")
