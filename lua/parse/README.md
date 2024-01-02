# makefile_parser_lua
parse makefile to abstract syntax tree 

## Usage

```lua 

local makefileText = readFromFile('path');
local parser = require('src.parser');
parser.parse(makefileText)

for pos=1, #parser.targets  do 
    print(parser.targets[pos].value)
end

```
