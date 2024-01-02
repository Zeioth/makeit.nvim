local M = {}

function readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function M.getText()
  return readAll('tests/data/Makefile')
end

function M.getTextSimple()
  return readAll('tests/data/MakefileSimple')
end

return M
