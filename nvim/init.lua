--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require 'settings'
require 'keybinds'
require 'commands'
require 'autocmd'
require 'neovide'
require 'terminal'

require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- Git related plugins
  { 'lewis6991/gitsigns.nvim', opts = {} },
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  { 'echasnovski/mini.nvim', version = '*' },
  'folke/snacks.nvim', -- for input provider snacks

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ 'css', 'javascript', 'lua', 'vim', 'toml', 'svelte', 'typescript' }, {
        -- RGB      = true,         -- #RGB hex codes
        -- RRGGBB   = true,         -- #RRGGBB hex codes
        -- names    = true,         -- "Name" codes like Blue
        -- RRGGBBAA = true,         -- #RRGGBBAA hex codes
        -- rgb_fn   = false,         -- CSS rgb() and rgba() functions
        -- hsl_fn   = false,        -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        -- css_fn = false,          -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = 'background', -- Set the display mode.
      })
    end,
  },

  'nvim-lualine/lualine.nvim',

  'folke/which-key.nvim',

  { 'numToStr/Comment.nvim', opts = {} },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      debounce = 200,
      indent = { char = '▏' },
      whitespace = { highlight = { 'Whitespace', 'NonText' } },
      -- scope = { exclude = { language = { "lua" } } },
    },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>ac',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
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

      'benfowler/telescope-luasnip.nvim',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'David-Kunz/cmp-npm',
      'hrsh7th/cmp-emoji',
    },
  },

  { 'akinsho/toggleterm.nvim', version = '*', config = true },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'xiyaowong/telescope-emoji.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- yank animations
  {
    'rachartier/tiny-glimmer.nvim',
    event = 'TextYankPost',
    opts = {
      transparency_color = nil,
      default_animation = 'pulse',
      animations = {
        left_to_right = {
          max_duration = 500,
          chars_for_max_duration = 100,
          ligering_time = 200,
          from_color = 'DiffText',
          to_color = 'DiffChange',
        },
        pulse = {
          max_duration = 400,
          chars_for_max_duration = 15,
          pulse_count = 2,
          intensity = 1.2,
          from_color = 'DiffText',
          to_color = 'DiffChange',
        },
      },
    },
  },

  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown', 'Avante' },
    },
    ft = { 'markdown', 'Avante' },
  },
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   build = 'cd app && npm install && git restore .',
  --   -- or if you use yarn: (I have not checked this, I use npm)
  --   -- build = "cd app && yarn install && git restore .",
  --   init = function()
  --     vim.g.mkdp_filetypes = { 'markdown' }
  --   end,
  --   ft = { 'markdown' },
  -- },

  'fladson/vim-kitty',

  'mbbill/undotree',

  require 'plugins.lint',
  require 'plugins.debug',
  require 'plugins.ai',
  require 'plugins.colors',
  require 'plugins.diagnostics',
  require 'plugins.lsp',
}, {})

require 'config.lsp'
require('config.ai').setup()

require('plugins.closer').setup()

vim.keymap.set('n', '<leader>gg', function()
  vim.cmd.Git()
  vim.cmd.call 'feedkeys("\\<C-w>L")'
end, { desc = 'use :Git plugin' })

vim.keymap.set('n', '<leader>u', function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end, { desc = 'Toggle undotree' })

-- vim: ts=2 sts=2 sw=2 et
