--- Run the selected make option using overseer

local M = {}


function M.run_makefile(option)
  local overseer = require("overseer")
  local final_message = "--task finished--"
  local task = overseer.new_task({
    name = "- Make interpreter",
    strategy = { "orchestrator",
      tasks = {{ "shell", name = "- Run makefile → make " .. option ,
          cmd = "make ".. option ..                                          -- run
                " && echo make " .. option ..                                -- echo
                " && echo '" .. final_message .. "'"
      },},},})
  task:start()
  vim.cmd("OverseerOpen")
end

return M
