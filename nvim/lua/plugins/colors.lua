local C = {
  {
    'catppuccin/nvim',
    as = 'catppuccin',
  },
  'RRethy/base16-nvim',
  'atelierbram/Base2Tone-nvim',
  'xiyaowong/transparent.nvim',
  {
    'vague2k/vague.nvim',
  },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  -- 'NLKNguyen/papercolor-theme',
  -- {
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       -- optional configuration here
  --     }
  --     require('bamboo').load()
  --   end,
  -- },
  -- {
  --   'uloco/bluloco.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     -- your optional config goes here, see below.
  --   end,
  -- },
}

return C
