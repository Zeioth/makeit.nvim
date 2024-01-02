local linter = require('src.linter');
local token_types = require('src.token_types')


lu = require('luaunit')


function testSimple()
  local text   = require('tests.file').getTextSimple()
  local result = linter.parse(text)

  lu.assertEquals(result[1].type, token_types.VARIABLE)
  lu.assertEquals(result[1].value, "DOCKER_COMP")
  lu.assertEquals(result[1].command, "docker compose")

  lu.assertEquals(result[2].type, token_types.SPECIAL_TARGET_NAME)
  lu.assertEquals(result[2].value, "DEFAULT_GOAL")
  lu.assertEquals(result[2].command, "help")

  lu.assertEquals(result[3].type, token_types.SPECIAL_TARGET_NAME)
  lu.assertEquals(result[3].value, "PHONY")
  lu.assertEquals(result[3].command, "help build up start down logs sh composer vendor sf cc test")


  lu.assertEquals(result[4].type, token_types.COMMENT)
  lu.assertEquals(result[4].value, "# —— Docker 🐳 ————————————————————————————————————————————————————————————————")

  lu.assertEquals(result[5].type, token_types.TARGET)
  lu.assertEquals(result[5].value, "build")

  lu.assertEquals(result[6].type, token_types.COMMENT)
  lu.assertEquals(result[6].value, "# Builds the Docker images")

  lu.assertEquals(result[7].type, token_types.RECIPE)
  lu.assertEquals(result[7].value, "@$(DOCKER_COMP) build")

  lu.assertEquals(result[8].type, token_types.TARGET)
  lu.assertEquals(result[8].value, "build-cache")

  lu.assertEquals(result[9].type, token_types.COMMENT)
  lu.assertEquals(result[9].value, "# Builds the Docker")

  lu.assertEquals(result[10].type, token_types.RECIPE)
  lu.assertEquals(result[10].value, "@$(DOCKER_COMP) build --pull --no-cache")
end

function testHard()
  local text   = require('tests.file').getText()
  local result = linter.parse(text)

  lu.assertEquals(result[1].type, token_types.COMMENT)
  lu.assertEquals(result[1].value, " Executables (local)")

  lu.assertEquals(result[2].type, token_types.VARIABLE)
  lu.assertEquals(result[2].value, "DOCKER_COMP")
end

os.exit(lu.LuaUnit.run())
