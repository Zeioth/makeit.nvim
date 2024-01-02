local token_types = require "parser.token_types"
local M = {
  position = 0,
  column = 0,
  row = 0,
  text = "",
}
function M.trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function M.parse(text)
  M.text       = text
  M.position   = 0
  M.column     = 0
  M.row        = 0

  local result = {};
  while not M.isEnd() do
    local value = M.readNext()
    if value then
      table.insert(result, value)
    end
  end
  return result;
end

function M.readNext()
  while not M.isEnd() do
    if M.isSpecialTargetName() then
      return M.readSpecialTargetName()
    end

    if M.isComment() then
      return M.readComment();
    end

    if M.isRecipe() then
      return M.readRecipe()
    end

    if M.isVariable() then
      return M.readVariable()
    end

    if M.isTarget() then
      return M.readTarget()
    end
    M.nextSymbol()
  end
  return nil;
end

function M.nextSymbol()
  M.position = M.position + 1

  if M.isNewLine() then
    M.position = M.position + 1
    M.column = 0
    M.row = M.row + 1
  else
    M.column = M.column + 1
  end
end;

function M.isNewLine()
  local currentSymbol = M.getCurrentSymbol();
  return M.symbolIsNewLine(currentSymbol)
end

function M.symbolIsNewLine(currentSymbol)
  if currentSymbol == '\n\r' or currentSymbol == '\n' or currentSymbol == '\r' then
    return true;
  end
  return false
end

function M.getCurrentSymbol()
  return string.sub(M.text, M.position, M.position)
end;

function M.isEnd()
  return M.position >= string.len(M.text)
end

function M.isComment()
  local currentSymbol = M.getCurrentSymbol();
  if currentSymbol == '#' then
    return true;
  end
  return false
end

function M.readComment()
  M.nextSymbol();
  local row    = M.row
  local column = M.column
  local text   = ""
  while not M.isEnd() do
    text = text .. M.getCurrentSymbol();
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  return token_types.createToken(token_types.COMMENT, text, row, column)
end

function M.isRecipe()
  local currentSymbol = M.getCurrentSymbol();
  if currentSymbol == '	' then
    return true;
  end
  return false
end

function M.readRecipe()
  M.nextSymbol();
  local row    = M.row
  local column = M.column
  local text   = ""
  while not M.isEnd() do
    text = text .. M.getCurrentSymbol();
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  return token_types.createToken(token_types.RECIPE, text, row, column)
end

function M.isSpecialTargetName()
  local currentSymbol = M.getCurrentSymbol();
  if currentSymbol == '.' then
    return true;
  end
  return false
end

function M.readSpecialTargetName()
  M.nextSymbol();
  local row     = M.row
  local column  = M.column
  local text    = ""
  local isName  = true;
  local command = "";
  while not M.isEnd() do
    if isName then
      if M.getCurrentSymbol() == ':' or M.getCurrentSymbol() == '=' then
        isName = false
        M.nextSymbol()
      else
        text = text .. M.getCurrentSymbol();
      end
    else
      if M.isComment() then
        break
      end
      command = command .. M.getCurrentSymbol()
    end
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  local result = token_types.createToken(token_types.SPECIAL_TARGET_NAME, M.trim(text), row, column)
  if command then
    result.command = M.trim(command)
    -- result.command = command
  else
    result.command = ""
  end
  return result
end

function M.isTarget()
  local endPos = string.len(M.text);
  for pos = M.position, endPos do
    local symbol = string.sub(M.text, pos, pos)
    local symbolTest = string.sub(M.text, pos, pos + 5)
    if M.symbolIsNewLine(symbol) then
      return false
    end
    if symbol == ":" then
      return true
    end
  end
  return false;
end

function M.readTarget()
  local row           = M.row
  local column        = M.column
  local text          = ""
  local isName        = true;
  local prerequisites = "";
  while not M.isEnd() do
    if isName then
      if M.getCurrentSymbol() == ':' then
        isName = false
        M.nextSymbol()
      else
        text = text .. M.getCurrentSymbol();
      end
    else
      if M.isComment() then
        break
      end
      prerequisites = prerequisites .. M.getCurrentSymbol()
    end
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  local result = token_types.createToken(token_types.TARGET, M.trim(text), row, column)
  if prerequisites then
    result.prerequisites = M.trim(prerequisites)
  else
    result.prerequisites = ""
  end
  return result
end

function M.isVariable()
  local endPos = string.len(M.text);
  for pos = M.position, endPos do
    local symbol = string.sub(M.text, pos, pos)
    if M.symbolIsNewLine(symbol) then
      return false
    end
    if symbol == "=" then
      return true
    end
  end
  return false;
end

function M.readVariable()
  local row     = M.row
  local column  = M.column
  local text    = ""
  local isName  = true;
  local command = "";
  while not M.isEnd() do
    if isName then
      if M.getCurrentSymbol() == '=' then
        isName = false
        M.nextSymbol()
      else
        text = text .. M.getCurrentSymbol();
      end
    else
      if M.isComment() then
        break
      end
      command = command .. M.getCurrentSymbol()
    end
    local nextSymbol = string.sub(M.text, M.position + 1, M.position + 1)
    if M.symbolIsNewLine(nextSymbol) then
      break
    end
    M.nextSymbol()
  end
  local result = token_types.createToken(token_types.VARIABLE, M.trim(text), row, column)
  if command then
    result.command = M.trim(command)
  else
    result.command = ""
  end
  return result
end

return M
