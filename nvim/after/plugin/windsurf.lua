local enable_windsurf = false

if enable_windsurf then
  vim.g.codeium_no_map_tab = true
  vim.g.codeium_disable_bindings = true

  require('codeium').setup {
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      manual = false,
      filetypes = {},
      default_filetype_enabled = true,
      idle_delay = 75,
      virtual_text_priority = 65535,
      map_keys = true,
      accept_fallback = '<CR>',
      key_bindings = {
        accept = '<M-l>',
        accept_word = false,
        accept_line = '<M-i>',
        clear = '<M-o>',
        next = '<M-]>',
        prev = '<M-[>',
      },
    },
  }
end
