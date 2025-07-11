transparent = require 'transparent'

my_favs = {
  'kanso-zen',
  'kanso-ink',
  'vague',
  'catppuccin',
  'base16-qualia',
  'base16-embers',
  -- cool pink/pastel
  'base2tone_cave_dark',
  -- night mode
  'base16-mountain',
  'base16-embers',
  'base16-rose-pine-moon',
  'base2tone_pool_dark',
  'base2tone_motel_dark',
  -- cool night
  'base16-black-metal',
  -- hm
  'base16-tokyodark',
  'base16-qualia',
  -- nah
  -- "base16-kanagawa",
  -- strong contrast
  'base16-tokyo-night-dark',
  -- "base16-chalk",
  -- "base2tone_desert_dark",
  -- interesing 🧙
  'base16-uwunicorn',
  'base16-stella',
}

-- default selected index
local selected = 1
function set_fav_colors(verbose)
  local new_color = my_favs[selected]
  vim.cmd.colorscheme(new_color)
  if verbose then
    print(new_color)
  end
end

vim.keymap.set('n', [[<leader>cs]], function()
  require('telescope.builtin').colorscheme { enable_preview = true }
end, { desc = 'Select color schemes from my fav' })

vim.keymap.set('n', [[<leader>cp]], function()
  selected = selected - 1
  set_fav_colors(true)
end, { desc = 'Select prev color scheme from my fav' })
vim.keymap.set('n', [[<leader>cn]], function()
  selected = selected + 1
  set_fav_colors(true)
end, { desc = 'Select next color scheme from my fav' })

-- transparent config
transparent.setup {
  extra_groups = {
    'NormalFloat',
    'FloatBorder',
  },
}
transparent.clear_prefix 'Telescope'
transparent.clear_prefix 'GitSigns'
transparent.clear_prefix 'MiniFiles'
-- transparent.clear_prefix('MiniNotify')
transparent.clear_prefix 'NvimTree'
transparent.clear_prefix 'Cmp'

require('kanso').setup {
  transparent = false, -- do not set background color
  dimInactive = true, -- dim inactive window `:h hl-NormalNC`
}

-- setup must be called before loading
vim.cmd 'colorscheme kanso'

require('vague').setup {
  transparent = false, -- don't set background
  -- disable bold/italic globally in `style`
  bold = true,
  italic = true,
  style = {
    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
    boolean = 'bold',
    number = 'none',
    float = 'none',
    error = 'bold',
    comments = 'italic',
    conditionals = 'none',
    functions = 'none',
    headings = 'bold',
    operators = 'none',
    strings = 'italic',
    variables = 'none',

    -- keywords
    keywords = 'none',
    keyword_return = 'italic',
    keywords_loop = 'none',
    keywords_label = 'none',
    keywords_exception = 'none',

    -- builtin
    builtin_constants = 'bold',
    builtin_functions = 'none',
    builtin_types = 'bold',
    builtin_variables = 'none',
  },
  -- plugin styles where applicable
  -- make an issue/pr if you'd like to see more styling options!
  plugins = {
    cmp = {
      match = 'bold',
      match_fuzzy = 'bold',
    },
    dashboard = {
      footer = 'italic',
    },
    lsp = {
      diagnostic_error = 'bold',
      diagnostic_hint = 'none',
      diagnostic_info = 'italic',
      diagnostic_ok = 'none',
      diagnostic_warn = 'bold',
    },
    neotest = {
      focused = 'bold',
      adapter_name = 'bold',
    },
    telescope = {
      match = 'bold',
    },
  },

  -- Override highlights or add new highlights
  on_highlights = function(highlights, colors) end,

  -- Override colors
  colors = {
    bg = '#141415',
    fg = '#cdcdcd',
    floatBorder = '#878787',
    line = '#252530',
    comment = '#606079',
    builtin = '#b4d4cf',
    func = '#c48282',
    string = '#e8b589',
    number = '#e0a363',
    property = '#c3c3d5',
    constant = '#aeaed1',
    parameter = '#bb9dbd',
    visual = '#333738',
    error = '#d8647e',
    warning = '#f3be7c',
    hint = '#7e98e8',
    operator = '#90a0b5',
    keyword = '#6e94b2',
    type = '#9bb4bc',
    search = '#405065',
    plus = '#7fa563',
    delta = '#f3be7c',
  },
}

set_fav_colors()
