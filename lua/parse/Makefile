# Default prefix
PREFIX = /usr/local

# System's lua directory (where Lua libraries are installed)
LUA_DIR= $(PREFIX)/share/lua/5.1

LUAS= src/logging/console.lua src/logging/email.lua src/logging/file.lua src/logging/rolling_file.lua src/logging/socket.lua src/logging/sql.lua src/logging/nginx.lua src/logging/rsyslog.lua src/logging/envconfig.lua
ROOT_LUAS= src/logging.lua



test:
	lua tests/linter_test.lua
	lua tests/parser_test.lua

