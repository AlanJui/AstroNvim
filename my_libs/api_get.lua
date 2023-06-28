-- package.path = "/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;"
-- package.path = "/Users/alanjui/.luarocks/share/lua/5.1/?.lua;/Users/alanjui/.luarocks/share/lua/5.1/?/init.lua;"
--   .. package.path
-- package.cpath = "/Users/alanjui/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;"
-- package.path = "/Users/alanjui/.luarocks/share/lua/5.4/?.lua;" .. package.path
-- package.path = "/usr/local/share/lua/5.4/?.lua" .. package.path
-- package.cpath = "/usr/local/lib/lua/5.4/?.so" .. package.cpath

local http_request = require "http.request"
local json = require "json"

local function get_message()
  local req = http_request.new_from_uri "http://localhost:8000/api/huan_tshiat_huat/"
  local headers, stream = req:go()
  local body = stream:get_body_as_string()
  local data = json:decode(body)
  return data.message
end

vim.api.nvim_buf_set_lines(0, 0, -1, false, { get_message() })
