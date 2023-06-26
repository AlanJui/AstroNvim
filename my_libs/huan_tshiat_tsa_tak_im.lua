-- 宣告模組（Module）搜尋路徑
package.path = "/Users/alanjui/.luarocks/share/lua/5.4/?.lua;" .. package.path
package.path = "/usr/local/Cellar/luarocks/3.9.2/share/lua/5.4/?.lua" .. package.path
package.cpath = "/usr/local/Cellar/luarocks/3.9.2/share/lua/5.4/?.so"

-- 載入 http 模組
local http_request = require "http.request"

-- 取得目前游標所在位置的漢字
-- local han_ji = vim.fn.expand "<cword>"
local han_ji = "在"

-- 發送 HTTP 請求，要求伺服器查詢「漢字」的「反切讀音」及「台羅拼音」
local url = "http://localhost:8000/api/huan_tshiat_huat/?han_ji=" .. han_ji
local req = http_request.new_from_uri(url)
---@diagnostic disable-next-line: unused-local
local headers, stream = assert(req:go())
local body = stream:get_body_as_string()

-- 解析響應資料為 Lua 表
local han_ji_dict = vim.fn.json_decode(body)

-- 顯示查詢結果
if han_ji_dict then
  print "=============================================="
  print("【查找漢字】：" .. tostring(han_ji_dict["han_ji"]))
  if han_ji_dict["tak_im_list"] and #han_ji_dict["tak_im_list"] > 0 then
    for _, tak_im in ipairs(han_ji_dict["tak_im_list"]) do
      print "----------------------------------------------"
      print("【反切讀音】：" .. tak_im["huan_tshiat"])
      print("【拼音字母】：" .. tak_im["piau_im"])
      print("【查詢結果】：" .. vim.inspect(tak_im))
    end
  else
    print "找不到反切讀音"
  end
else
  print "找不到反切讀音"
end

-- local lua_http_variable = require "http.request"
-- local new_http_variable = lua_http_variable.new_from_uri "http://lua.org/demo"
-- local headers, stream = assert(new_http_variable:go())
-- for lua_field, lua_value in headers:each() do
--   print(lua_field, lua_value)
-- end
-- local body_http_variable = assert(stream:get_body_as_string())
-- print(body_http_variable)
