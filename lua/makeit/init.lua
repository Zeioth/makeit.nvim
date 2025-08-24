--- ### Commands for makeit.nvim
-- This plugin is just a wrapper for overseer.nvim that displays
-- tasks to list and run your makefile tasks asynchronously.

local cmd = vim.api.nvim_create_user_command
local M = {}

---@class MakeitConfig
---@field picker string "telescope" or "snacks"
local config = {
  picker = "telescope", -- "telescope" or "snacks"
}

---@param opts MakeitConfig
M.setup = function(opts)
  if opts then config = vim.tbl_extend("force", config, opts) end

  cmd("MakeitOpen", function()
    if opts.picker == "snacks" then
      require("makeit.snacks").show()
    else
      require("makeit.telescope").show()
    end
  end, { desc = "Open makeit" })

  cmd(
    "MakeitToggleResults",
    function() vim.cmd("OverseerToggle") end,
    { desc = "Toggle makeit results" }
  )

  cmd("MakeitRedo", function()
    -- If the user didn't select an option yet, send a notification.
    if _G.makeit_redo == nil then
      vim.notify(
        "Open makeit and select an option before doing redo.",
        vim.log.levels.INFO,
        {
          title = "Makeit.nvim",
        }
      )
      return
    end
    -- Redo
    require("makeit.backend").run_makefile(_G.makeit_redo)
  end, { desc = "Redo the last selected makeit option" })

  cmd("MakeitStop", function()
    vim.notify(
      "SUCCESS - All tasks have been disposed.",
      vim.log.levels.INFO,
      {
        title = "Compiler.nvim",
      }
    )
    local overseer = require("overseer")
    local tasks = overseer.list_tasks({ unique = false })
    for _, task in ipairs(tasks) do
      overseer.run_action(task, "dispose")
    end
  end, { desc = "Dispose all tasks running in makeit" })
end

return M
