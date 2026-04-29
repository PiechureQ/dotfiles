--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
--  ustawienie "leadera" czyli klawisza na którym bazują wszystkie.
--  od niego zaczyna się większość mapowań.
--  najczęściej używany jest <space> czyli ' '
--  mozesz sobie zmienić
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

-- ustawienia edytora.
-- tip. 'gf' to skrót który otwiera plik który jest pod kursorem
-- każde z tych ustawień można wyszukać w :help i dowiedzieć się co robią
require 'settings'
-- bazowe mapowania klawiszy
require 'keybinds'

require('lazy').setup({
  -- Git related plugins
  { 'lewis6991/gitsigns.nvim', opts = {} },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- wyświetla dostępne skróty klawiszowe na ekranie
  'folke/which-key.nvim',

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('', '-', ':NvimTreeToggle<CR>', { desc = 'toggle file tree' })
    end,
  },

  -- wtyczka dodająca wyszukiwarkę plików, wyszukiwarkę fraz w całym projekcie itd
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- Wtyczka dodająca więcej podpowiedzi w oknie podpowiadania
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Adds LSP completion capabilities
      -- 'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },

  -- wtyczki do działania lsp (Language Service Protocol).
  -- dzięki temu można np przejsc do definicji funkcji, znaleść wszystkie użycia zmiennej itp.
  -- require 'plugins.lsp',
}, {})

-- konfiguracja mapowania klawiszy do funkcji lsp
-- najlepiej samemu się zapoznać, lub poprosić o podsumownie ai 😀
-- require 'config.lsp'

-- vim: ts=2 sts=2 sw=2 et
