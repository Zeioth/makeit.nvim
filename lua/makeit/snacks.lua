local M = {}

function M.show()
  local utils = require("makeit.utils")
  local options =
    utils.get_makefile_options(utils.os_path(vim.fn.getcwd() .. "/Makefile"))

  local items = vim.tbl_map(
    function(entry)
      return {
        txt = entry.text,
        value = entry.value,
      }
    end,
    options
  )

  require("snacks").picker.select(items, {
    prompt = "Makeit",
    format_item = function(item) return item.txt end,
  }, function(choice)
    if choice then
      _G.makeit_redo = choice.value
      require("makeit.backend").run_makefile(choice.value)
    end
  end)
end

return M
