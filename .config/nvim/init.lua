--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- "tommcdo/vim-fubitive",
  'lewis6991/gitsigns.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'fladson/vim-kitty',

  'norcalli/nvim-colorizer.lua',

  'nvim-lualine/lualine.nvim',

  'folke/which-key.nvim',

  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',

  'mbbill/undotree',

  'zbirenbaum/copilot.lua',

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = "▏",
      show_trailing_blankline_indent = false,
    },
  },


  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true, opts = { ui = { border = "rounded", } } },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {
          window = {
            blend = 0,
          },
        }
      },

      "folke/trouble.nvim",

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      "benfowler/telescope-luasnip.nvim",

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "David-Kunz/cmp-npm",
      "hrsh7th/cmp-emoji",

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "nvim-telescope/telescope-fzy-native.nvim",
        "xiyaowong/telescope-emoji.nvim",
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    build = ':TSUpdate',
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons" },
  },

  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  }

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
}, {})

require("settings")
require("keybinds")
require("commands")
require("autocmd")
require("lsp")

vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = 'use :Git plugin' })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- vim: ts=2 sts=2 sw=2 et
