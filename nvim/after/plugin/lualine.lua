local lualine = require 'lualine'
local ll_mode = require('lualine.utils.mode').get_mode

-- mini.icons
require('mini.icons').setup()

-- mock nvim-web-devicons to use mini.icons instead
require('mini.icons').mock_nvim_web_devicons()

local mode_name = {
  function()
    return string.lower(ll_mode())
  end,
}

local mode = {
  -- mode component
  function()
    local mode = {
      NORMAL = '😎',
      ['O-PENDING'] = '😤',
      VISUAL = '😯',
      ['V-LINE'] = '😯',
      ['V-BLOCK'] = '😯',
      SELECT = '🔍',
      ['S-LINE'] = '🔍',
      ['S-BLOCK'] = '🔍',
      INSERT = '😨',
      REPLACE = '😰',
      ['V-REPLACE'] = '😰',
      COMMAND = '🤔',
      EX = '🤔',
      MORE = '😑',
      CONFIRM = '👍',
      SHELL = '🏃',
      TERMINAL = '🤓',
    }
    return mode[ll_mode()]
  end,
}

local filename = {
  'filename',
  symbols = {
    modified = '~',
    readonly = '-',
    unnamed = '[]',
    newfile = '+',
  },
  separator = '',
}

local filetype = {
  'filetype',
  colored = true,
  icon_only = true,
  padding = { right = 2 },
}

local filetype_inactive = {
  'filetype',
  colored = false,
  icon_only = true,
  padding = { right = 2 },
}

local diagnostics = {
  'diagnostics',
  symbols = { error = ' ', warn = ' ', info = ' ' },
  sources = { 'nvim_diagnostic' },
}

local branch = {
  'branch',
  icon = '',
}

local idk = {
  function()
    return ' ⛧'
  end,
}

local tabs = {
  'tabs',
  max_length = vim.o.columns,
  mode = 1,
  fmt = function(name, context)
    -- get buffer edited
    local buflist = vim.fn.tabpagebuflist(context.tabnr)
    local winnr = vim.fn.tabpagewinnr(context.tabnr)
    local bufnr = buflist[winnr]
    local mod = vim.fn.getbufvar(bufnr, '&mod')
    -- get icon
    -- local ext = string.match(name, "%.([^.]+)$")
    local icon = ''
    -- if ext then
    --   icon = require 'nvim-web-devicons'.get_icon(name, ext)
    --   if not icon then icon = '' end
    -- end

    return name .. (mod == 1 and ' ~' or '') .. ' ' .. icon
  end,
}

local function get_lsp_client_name()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return nil
end

local lsp_server = {
  -- Lsp server name .
  get_lsp_client_name,
  cond = function()
    return get_lsp_client_name() ~= nil
  end,
  icon = ' LSP:',
}

local trouble = require 'trouble'
local symbols = trouble.statusline {
  mode = 'lsp_document_symbols',
  groups = {},
  title = false,
  filter = { range = true },
  format = '{kind_icon}{symbol.name:Normal}',
  -- The following line is needed to fix the background color
  -- Set it to the lualine section you want to use
  hl_group = 'lualine_c_normal',
}
local get_symbols = {
  symbols.get,
  cond = symbols.has,
}

-- Config
local config = {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    theme = 'auto',
  },
  refresh = {
    statusline = 300,
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename, filetype_inactive },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_a = {
      mode_name,
    },
    lualine_b = {
      filename,
      filetype,
      get_symbols,
    },
    lualine_c = { 'diff', diagnostics },

    lualine_x = { 'searchcount', 'location', 'progress' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { tabs },
    lualine_x = { branch, idk },
    lualine_y = {},
    lualine_z = {},
  },
}
lualine.setup(config)
