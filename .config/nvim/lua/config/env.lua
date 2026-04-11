local M = {}

function M.load()
  local path = vim.g.env_file or (vim.fn.getcwd() .. "/.env")
  local env = {}
  local f = io.open(path, "r")
  if not f then
    return env
  end
  for line in f:lines() do
    if not line:match("^%s*#") and not line:match("^%s*$") then
      local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
      if key and value then
        value = value:match("^[\"'](.-)[\"']$") or value
        env[key] = value
      end
    end
  end
  f:close()
  return env
end

return M
