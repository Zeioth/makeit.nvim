local M           = {
  currentPosition = 0,
  variables = {},
  special_target_name = {},
  targets = {},
  tokens = {},
}

local token_types = require('parser.token_types')
function M.parse(text)
  M.currentPosition     = 0;
  M.variables           = {};
  M.special_target_name = {};
  M.targets             = {};
  M.tokens              = {}
  local linter          = require('parser.linter');
  M.tokens              = linter.parse(text)
  local currentTarget   = nil;
  while not M.isEnd() do
    local token = M.getCurrentToken()
    if token == nil then
      goto continue
    end
    if token.type == token_types.VARIABLE then
      table.insert(M.variables, M.parseVariable())
    end;
    if token.type == token_types.SPECIAL_TARGET_NAME then
      table.insert(M.special_target_name, M.parseSpecialTarget())
      goto continue
    end;

    if token.type == token_types.TARGET then
      table.insert(M.targets, M.parseTarget())
      goto continue
    end
    ::continue::
    M.nextToken()
  end
end

function M.parseVariable()
  local token = M.getCurrentToken()
  local comment = "";
  local nextToken = M.getNextToken()
  if nextToken and nextToken.type == token_types.COMMENT then
    comment = nextToken.value
    M.nextToken()
  end

  return {
    comment = comment,
    token = token,
    value = token.value
  }
end;

function M.parseSpecialTarget()
  local token = M.getCurrentToken()
  local comment = "";
  local nextToken = M.getNextToken()
  if nextToken and nextToken.type == token_types.COMMENT then
    comment = nextToken.value
    M.nextToken()
  end
  return {
    comment = comment,
    token = token,
    value = token.value
  }
end;

function M.parseTarget()
  local token = M.getCurrentToken()
  local comment = "";
  local nextToken = M.getNextToken()
  if nextToken and nextToken.type == token_types.COMMENT then
    comment = nextToken.value
    M.nextToken()
    nextToken = M.getNextToken()
  end
  local result = {
    comment = comment,
    token = token,
    recipes = {},
    value = token.value

  }
  while nextToken and nextToken.type == token_types.RECIPE do
    M.nextToken()
    local tok = M.getCurrentToken()
    if tok == nil then
      break
    end
    local recipe = {
      value = tok.value,
      token = token,
      comment = ""
    }
    table.insert(result.recipes, recipe)

    nextToken = M.getNextToken()
  end

  return result;
end;

function M.isEnd()
  return M.currentPosition >= #M.tokens
end

function M.nextToken()
  M.currentPosition = M.currentPosition + 1
end;

function M.getCurrentToken()
  if M.currentPosition >= #M.tokens then
    return nil
  end;
  return M.tokens[M.currentPosition]
end

function M.getNextToken()
  local position = M.currentPosition + 1
  if position >= #M.tokens then
    return nil
  end;
  return M.tokens[position]
end

return M
