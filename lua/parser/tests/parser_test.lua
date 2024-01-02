local token_types = require('src.token_types')


lu = require('luaunit')


function testSimple()
  local parser = require('src.parser');
  local text = require('tests.file').getTextSimple()
  parser.parse(text)
  local targets = parser.targets

  lu.assertEquals(targets[1].value, "build")
  lu.assertEquals(targets[1].comment, "# Builds the Docker images")

  lu.assertEquals(targets[2].value, "build-cache")
  lu.assertEquals(targets[2].comment, "# Builds the Docker")
end

function testHard()
  local parser = require('src.parser');
  local text = require('tests.file').getText()
  parser.parse(text)
  local targets = parser.targets

  lu.assertEquals(targets[1].value, "help")
  lu.assertEquals(targets[2].value, "build")
  lu.assertEquals(targets[9].value, "test")
  lu.assertEquals(targets[9].comment, "# test")
  lu.assertEquals(targets[14].value, "entity-api-resource")
end

os.exit(lu.LuaUnit.run())
