local local_module = 'local'

local config = {
  copilot_provider = '',
  avante = false,
}

local local_config_success, local_config = pcall(require, local_module)

if local_config_success then
  -- Połącz tabele
  for k, v in pairs(local_config) do
    config[k] = v
  end
end

return config
