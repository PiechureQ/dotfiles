local Convert = {}

-- tutaj trzymamy "konwersje"
Convert.global = {} -- globalne nazwy dostępne w każdym języku
Convert.per_language = {} -- np. { javascript = { require = function() ... end } }
-- lista typów plików do których chcemy przypisać log
local js_like = { 'javascript', 'typescript', 'typescriptreact', 'svelte' }

function Convert.with(langs_array)
  if type(langs_array) == 'string' then
    return langs_array
  end
  local result = {}
  for _, lang_item in ipairs(langs_array) do
    local flat = Convert.with(lang_item)
    if type(lang_item) == 'string' then
      table.insert(result, lang_item)
    else
      for _, v in ipairs(flat) do
        table.insert(result, v)
      end
    end
  end
  return result
end

-- 🔹 rejestracja globalnej konwersji
function Convert.add_global(name, fn)
  Convert.global[name] = fn
end

-- 🔹 rejestracja konwersji dla języka
function Convert.add_for(lang, name, fn)
  -- jeśli lang jest stringiem, zamieniamy na tabelę z jednym elementem
  if type(lang) == 'string' then
    lang = { lang }
  end
  -- przypisanie do każdego z filetype
  for _, l in ipairs(lang) do
    if not Convert.per_language[l] then
      Convert.per_language[l] = {}
    end
    Convert.per_language[l][name] = fn
  end
end

-- 🔹 zwraca dostępne nazwy dla danego bufora
function Convert.available()
  local ft = vim.bo.filetype
  local names = {}

  -- per-language
  if Convert.per_language[ft] then
    for k, _ in pairs(Convert.per_language[ft]) do
      table.insert(names, k)
    end
  end

  -- globalne
  for k, _ in pairs(Convert.global) do
    table.insert(names, k)
  end

  return names
end

-- 🔹 wykonanie konwersji
function Convert.run(name)
  local ft = vim.bo.filetype
  local fn

  -- najpierw sprawdzamy per-language
  if Convert.per_language[ft] and Convert.per_language[ft][name] then
    fn = Convert.per_language[ft][name]
  elseif Convert.global[name] then
    fn = Convert.global[name]
  end

  if fn then
    fn()
  else
    vim.notify('Brak konwersji o nazwie: ' .. name, vim.log.levels.WARN)
  end
end

-- 🔹 rejestracja komendy :Convert
vim.api.nvim_create_user_command('Convert', function(opts)
  Convert.run(opts.args)
end, {
  nargs = 1,
  complete = function(_, _, _)
    return Convert.available()
  end,
})

function Convert.setup()
  -- 👇 tu możesz definiować swoje konwersje
  Convert.add_global('test', function()
    vim.api.nvim_put({ 'Hello from Convert!' }, '', true, true)
  end)
  -- cosnt -> const
  Convert.add_for(Convert.with { js_like, 'zig' }, 'const', function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd [[%s/cosnt/const/gI]]
    vim.api.nvim_win_set_cursor(0, { row, col })
  end)

  -- require() -> import ... from ...
  Convert.add_for('javascript', 'require', function()
    vim.cmd [[%s/const\s\+\(\k\+\)\s*=\s*require(['"]\([^'"]\+\)['"]);/import \1 from "\2";/g]]
  end)
  Convert.add_for('javascript', 'export', function()
    vim.cmd [[%s/module.exports\s*=\s*\(.*$\)/export default \1/g]]
  end)

  -- globalna nazwa "log" → pobiera słowo pod kursorem i wstawia console.log(...)
  Convert.add_for(js_like, 'log', function()
    -- pobieramy słowo pod kursorem
    local word = vim.fn.expand '<cword>'
    local line = string.format('console.log("", %s);', word)
    vim.api.nvim_put({ line }, 'l', true, false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('0ci"', true, false, true), 'n', false)
  end)
  Convert.add_for('zig', 'log', function()
    -- pobieramy słowo pod kursorem
    local word = vim.fn.expand '<cword>'
    local line = string.format('std.debug.print("{s}", .{%s});', word)
    vim.api.nvim_put({ line }, 'l', true, false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('0ci"', true, false, true), 'n', false)
  end)

  -- mapping
  vim.keymap.set('n', '<leader>o', [[:Convert ]], { desc = 'Convert ...' })
  vim.keymap.set('n', '<leader>oc', [[:Convert const<cr>]], { desc = 'Convert const' })
  vim.keymap.set('n', '<leader>oo', [[:Convert log<cr>]], { desc = 'Convert log' })
end

return Convert
