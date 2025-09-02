local closer = {}

local keys = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ['<'] = '>',
  ['"'] = '"',
  ["'"] = "'",
  ['`'] = '`',
}
-- funkcja która przyjmuje znak i szuka czy występuje on przed kursorem
-- jeśli wystepuje to dodaje ten znak za kursorem
-- jeśli para jest zamknięta to kursor przechodzi do zamknięcia pary
-- function closer.close(char)
function closer.close(char)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local open_at = string.find(line:sub(1, col), char, 1, true)
  if open_at then
    local closed_at = string.find(line:sub(open_at + 1), keys[char], 1, true)
    if closed_at ~= nil then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row, open_at + closed_at })
    else
      -- jeśli występuje to dodaje ten znak za kursorem
      vim.cmd 'normal! e'
      vim.api.nvim_put({ keys[char] }, 'c', true, true)
    end
  end
end

function closer.find_nearest(search_keys)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local nearest = nil
  local open, close = nil, nil

  for _open, _close in pairs(search_keys) do
    local open_at = string.find(line:sub(1, col), _open, 1, true)
    if open_at ~= nil then
      if nearest == nil or open_at < nearest then
        nearest = open_at
        open = _open
        close = _close
      end
    end
  end

  return open, close
end
--
-- z listy zdefiniowanych par szuka tej która jest najbliższa i jest otwarta
-- zamyka tą która jest najlbliżej, i omija te które są zamknięte
-- function closer.close_nearest()
--
-- mapy klawiszy
-- zamknij parę pod
function closer.auto_close()
  local open, close = closer.find_nearest(keys)
  if open then
    print(open, close)
    closer.close(open)
  end
end

-- closer.auto_close()
-- test(sdjaksldjl
-- test(sdjaksldjl)
-- test{sdjaksldjl
-- test{sdjaksldjl}
-- test[sdjaksldjl
-- test[sdjaksldjl]
-- test"sdjaksldjl
-- test"sdjaksldjl"
-- test'sdjaksldjl
-- test'sdjaksldjl'

function closer.setup()
  vim.api.nvim_create_user_command('CloserAutoClose', closer.auto_close, {})
  -- vim.keymap.set('i', '<C-)>', closer.auto_close, { noremap = true, silent = true })
  vim.keymap.set('n', 'gp', closer.auto_close, { noremap = true, silent = true })
end

return closer
