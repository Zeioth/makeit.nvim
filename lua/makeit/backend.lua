--- Run the selected make option using overseer

local M = {}

function M.run_makefile(option)
  local overseer = require("overseer")
  local final_message = "--task finished--"
  local full_cmd = "make "
    .. option -- run
    .. " && echo make "
    .. option -- echo
    .. " && echo "
    .. final_message
  if vim.fn.has("win32") == 1 then full_cmd = 'cmd /c "' .. full_cmd .. '"' end

  local task = overseer.new_task({
    name = "- Make interpreter",
    strategy = {
      "orchestrator",
      tasks = {
        {
          "shell",
          name = "- Run makefile → make " .. option,
          cmd = full_cmd,
        },
      },
    },
  })
  task:start()
  vim.cmd("OverseerOpen")
end

return M
