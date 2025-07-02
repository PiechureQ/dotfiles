require('toggleterm').setup {
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 3,
  },
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
    return vim.o.lines * 0.5
  end,
  -- Add any other general toggleterm settings here
}
