local M = {
  TARGET              = 'target',
  COMMAND             = 'command',
  PREREQUISITES       = 'prerequisites',
  RECIPE              = 'recipe',
  VARIABLE            = 'variable',
  SPECIAL_TARGET_NAME = "special_target_names",
  COMMENT             = "comment"
}

function M.createToken(type, value, row, column)
  return {
    type   = type,
    value  = value,
    row    = row,
    column = column
  }
end

return M
