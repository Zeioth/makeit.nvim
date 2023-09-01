--- ### Frontend for makeit.nvim

local M = {}

function M.show()

  -- dependencies
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local state = require "telescope.actions.state"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local utils = require("makeit.utils")
  local options = utils.get_makefile_options(utils.os_path(vim.fn.getcwd() .. "/Makefile"))

  --- On option selected → Run action depending of the language
  local function on_option_selected(prompt_bufnr)
    actions.close(prompt_bufnr) -- Close Telescope on selection
    local selection = state.get_selected_entry()
    _G.makeit_redo = selection.value -- Save redo
    if selection then require "makeit.backend".run_makefile(selection.value) end
  end

  --- Show telescope
  local function open_telescope()
    pickers
      .new({}, {
        prompt_title = "Makeit",
        results_title = "Options",
        finder = finders.new_table {
          results = options,
          entry_maker = function(entry)
            return {
              display = entry.text,
              value = entry.value,
              ordinal = entry.text,
            }
          end,
        },
        sorter = conf.generic_sorter(),
        attach_mappings = function(_, map)
          map(
            "i",
            "<CR>",
            function(prompt_bufnr) on_option_selected(prompt_bufnr) end
          )
          map(
            "n",
            "<CR>",
            function(prompt_bufnr) on_option_selected(prompt_bufnr) end
          )
          return true
        end,
      })
      :find()
  end
  open_telescope() -- Entry point
end

return M
