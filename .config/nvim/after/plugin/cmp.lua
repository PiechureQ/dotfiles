local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  enable = true,
  autocomplete = false,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-l>'] = function()
      if cmp.visible() then
        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
      else
        cmp.complete()
      end
    end,
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end,
    }),
  },
  -- TODO https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'copilot' },
    { name = 'emoji' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'npm', keyword_length = 4 },
  }),
  experimental = {
    ghost_text = true,
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    { name = 'emoji' },
  }, {
    { name = 'buffer' },
  })
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  view = {
    entries = { name = "wildmenu", separator = " | " }
  },
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  completion = {
    autocomplete = false,
  },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
