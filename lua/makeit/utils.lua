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
  return string.gsub(path, "[/\\]", separator)
end

--- Given a path, open the file, extract all the Makefile keys,
--  and return them as a list.
---@param path string
---@return table options A telescope options list like
--{ { text: "1 - all", value="all" }, { text: "2 - hello", value="hello" } ...}
function M.get_makefile_options(path)
  local options = {}

  -- Open the Makefile for reading
  local file = io.open(path, "r")

  if file then
    local in_target = false
    local count = 0

    -- Iterate through each line in the Makefile
    for line in file:lines() do
      -- Check for lines starting with a target rule (e.g., "target: dependencies")
      local target = line:match("^([%.%w_-]+):")
      if target then
        in_target = true
        count = count + 1
        -- Exclude the ":" and add the option to the list with text and value fields
        table.insert(
          options,
          { text = count .. " - " .. target, value = target }
        )
      elseif in_target then
        -- If we're inside a target block, stop adding options
        in_target = false
      end
    end

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
