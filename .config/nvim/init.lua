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

require("settings")
require("keybinds")
require("commands")
require("autocmd")
require("neovide")

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- "tommcdo/vim-fubitive",
  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ '*' }, {
        RGB      = true,         -- #RGB hex codes
        RRGGBB   = true,         -- #RRGGBB hex codes
        names    = true,         -- "Name" codes like Blue
        RRGGBBAA = true,         -- #RRGGBBAA hex codes
        rgb_fn   = false,        -- CSS rgb() and rgba() functions
        hsl_fn   = false,        -- CSS hsl() and hsla() functions
        css      = false,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = false,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode     = 'background', -- Set the display mode.
      })
    end,
  },

  'nvim-lualine/lualine.nvim',

  'folke/which-key.nvim',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',   opts = {} },

  'mbbill/undotree',

  'zbirenbaum/copilot.lua',

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      debounce = 200,
      indent = { char = "▏" },
      whitespace = { highlight = { "Whitespace", "NonText" } },
      -- scope = { exclude = { language = { "lua" } } },
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
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      -- Adds a number of user-friendly snippets
      { 'rafamadriz/friendly-snippets' },
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
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
  },

  'fladson/vim-kitty',
}, {})

require("lsp")

vim.keymap.set('n', '<leader>gg', function()
    vim.cmd.Git()
    vim.cmd.call('feedkeys("\\<C-w>L")')
  end,
  { desc = 'use :Git plugin' })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- vim: ts=2 sts=2 sw=2 et
