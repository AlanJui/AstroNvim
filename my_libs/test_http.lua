package.path =
  "/usr/local/Cellar/luarocks/3.9.2/share/lua/5.1/?.lua;;/usr/local/share/lua/5.1/?.lua;?.lua;/Users/alanjui/.luarocks/share/lua/5.1/?.lua;/Users/alanjui/.luarocks/share/lua/5.1/?/init.lua;/usr/local/share/lua/5.1/?/init.lua"
package.cpath = ";/usr/local/lib/lua/5.1/?.so;?.lua;/Users/alanjui/.luarocks/lib/lua/5.1/?.so"

local http_request = require "http.request"
assert(http_request, "http_request is nil")
if http_request then
  print "http_request is not nil"
else
  print "http_request is nil"
end
