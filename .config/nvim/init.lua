-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
  -- Package manager
  use("wbthomason/packer.nvim")

  use({
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/plenary.nvim",

      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy" },

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",

      "folke/trouble.nvim",
    },
  })

  use({ "zbirenbaum/copilot.lua" })
  -- use {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  -- }

  use({
    "L3MON4D3/LuaSnip",
    tag = "v1.*",
    requires = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
    },
  })

  use({
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "David-Kunz/cmp-npm",
      "hrsh7th/cmp-emoji",
    },
  })

  use({
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    run = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  })
  use({
    -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  })
  use({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  })

  use("fladson/vim-kitty")

  use("nvim-lualine/lualine.nvim")

  -- use("tpope/vim-vinegar")
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")

  -- Git related plugins
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")
  use("tommcdo/vim-fubitive")
  use("lewis6991/gitsigns.nvim")

  -- use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  -- use 'ellisonleao/gruvbox.nvim'
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- Add indentation guides even on blank lines
  use("lukas-reineke/indent-blankline.nvim")
  -- "gc" to comment visual regions/lines
  use("numToStr/Comment.nvim")
  -- Detect tabstop and shiftwidth automatically
  use("tpope/vim-sleuth")

  use("norcalli/nvim-colorizer.lua")

  -- Fuzzy Finder (files, lsp, etc)
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
  use("nvim-telescope/telescope-fzy-native.nvim")
  use("xiyaowong/telescope-emoji.nvim")

  use("mbbill/undotree")

  use("folke/which-key.nvim")

  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  if is_bootstrap then
    require("packer").sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})

require("settings")
require("commands")
require("autocmd")
require("keybinds")
require("lsp")

-- plugins config
require("fidget").setup({
  window = {
    blend = 0,
  },
})
require("trouble").setup()
require("Comment").setup()
require("colorizer").setup()
require("indent_blankline").setup({
  char = "▏",
  show_trailing_blankline_indent = false,
})
require("mason").setup({
  ui = {
    border = "rounded",
  },
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- git command (fugitive)
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "use :Git plugin" })
