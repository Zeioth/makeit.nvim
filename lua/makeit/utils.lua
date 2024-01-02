--- ### Utils for makeit.nvim

local M = {}


--- Given a string, convert 'slash' to 'inverted slash' if on windows, and vice versa on UNIX.
-- Then return the resulting string.
---@param path string
---@return string|nil,nil
function M.os_path(path)
  if path == nil then return nil end
  -- Get the platform-specific path separator
  local separator = package.config:sub(1, 1)
  return string.gsub(path, '[/\\]', separator)
end

--- Given a path, open the file, extract all the Makefile keys,
--  and return them as a list.
---@param path string
---@return table options A telescope options list like
--{ { text: "1 - all", value="all" }, { text: "2 - hello", value="hello" } ...}
function M.get_makefile_options(path)
  local options = {}
  vim.notify(path)


  -- Open the Makefile for reading
  local file = io.open(path, "r")



  if file then
    local parser  = require('parser.parser')
    local allText = file:read("*all")
    parser.parse(allText)
    for pos = 1, #parser.targets do
      local target = parser.targets[pos]
      local text   = pos .. " - " .. target.value;
      if target.comment then
        text = text .. " #" .. target.comment
      end
      table.insert(
        options,
        { text = text, value = target.value }
      )
    end;

    -- Close the Makefile
    file:close()
  else
    vim.notify(
      "Unable to open a Makefile in the current working dir.",
      vim.log.levels.ERROR,
      {
        title = "Makeit.nvim",
      }
    )
  end

  return options
end

return M
