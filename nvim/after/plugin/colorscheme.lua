transparent = require("transparent")

my_favs = {
  "base16-qualia",
  "base16-embers",
  -- cool pink/pastel
  "base2tone_cave_dark",
  -- night mode
  "base16-mountain",
  "base16-embers",
  "base16-rose-pine-moon",
  "base2tone_pool_dark",
  "base2tone_motel_dark",
  -- cool night
  "base16-black-metal",
  -- hm
  "base16-tokyodark",
  "base16-qualia",
  -- nah
  -- "base16-kanagawa",
  -- strong contrast
  "base16-tokyo-night-dark",
  -- "base16-chalk",
  -- "base2tone_desert_dark",
  -- interesing 🧙
  "base16-uwunicorn",
  "base16-stella",
}

-- default selected index
local selected = 1;
function set_fav_colors(verbose)
  local new_color = my_favs[selected]
  vim.cmd.colorscheme(new_color);
  if verbose then
    print(new_color)
  end
end

set_fav_colors();

vim.keymap.set('n', [[<leader>cs]],
  function() require('telescope.builtin').colorscheme({ enable_preview = true }) end,
  { desc = "Select color schemes from my fav" })

vim.keymap.set('n', [[<leader>cp]],
  function()
    selected = selected - 1;
    set_fav_colors(true);
  end,
  { desc = "Select prev color scheme from my fav" })
vim.keymap.set('n', [[<leader>cn]],
  function()
    selected = selected + 1;
    set_fav_colors(true)
  end,
  { desc = "Select next color scheme from my fav" })

transparent.setup {
  extra_groups = {
    "NormalFloat",
    "FloatBorder",
  }
}
transparent.clear_prefix('Telescope')
transparent.clear_prefix('GitSigns')
transparent.clear_prefix('MiniFiles')
-- transparent.clear_prefix('MiniNotify')
transparent.clear_prefix('NvimTree')
transparent.clear_prefix('Cmp')
