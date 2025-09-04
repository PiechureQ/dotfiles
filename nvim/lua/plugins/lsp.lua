return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        tag = 'v1.5.0',
        opts = {
          -- Options related to notification subsystem
          notification = {
            override_vim_notify = true, -- Automatically override vim.notify() with Fidget
            window = {
              normal_hl = 'NormalFloat', -- Base highlight group in the notification window
              winblend = 0, -- Background color opacity in the notification window
              border = 'none', -- Border around the notification window
              zindex = 45, -- Stacking priority of the notification window
            },
          },
        },
      },
    },
  },
}
