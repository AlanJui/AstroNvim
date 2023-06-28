-- 宣告模組（Module）搜尋路徑
package.path = "/Users/alanjui/.luarocks/share/lua/5.4/?.lua;" .. package.path
package.path = "/usr/local/share/lua/5.4/?.lua" .. package.path
package.cpath = "/usr/local/lib/lua/5.4/?.so" .. package.cpath

-- 載入 http 模組
local http_request = require "http.request"

-- 取得目前游標所在位置的漢字
-- local han_ji = vim.fn.expand "<cword>"
local han_ji = "在"

-- 發送 HTTP 請求，要求伺服器查詢「漢字」的「反切讀音」及「台羅拼音」
local url = "http://localhost:8000/api/huan_tshiat_huat/?han_ji=" .. han_ji
local req = http_request.new_from_uri(url)
---@diagnostic disable-next-line: unused-local
local headers, stream = req:go()
local body = stream:get_body_as_string()

-- 解析響應資料為 Lua 表
local han_ji_dict = vim.fn.json_decode(body)

-- 創建新的緩衝區
local buf = vim.api.nvim_create_buf(false, true)

-- 將輸出內容寫入緩衝區
local lines = {
  "==============================================",
  "【查找漢字】：" .. han_ji,
}

if not han_ji_dict then
  table.insert(lines, "找不到反切讀音")
else
  if han_ji_dict["tak_im_list"] and #han_ji_dict["tak_im_list"] > 0 then
    for _, tak_im in ipairs(han_ji_dict["tak_im_list"]) do
      table.insert(lines, "----------------------------------------------")
      table.insert(lines, "【反切讀音】：" .. tak_im["huan_tshiat"])
      table.insert(lines, "【拼音字母】：" .. tak_im["piau_im"])
      table.insert(lines, "【查詢結果】：" .. vim.inspect(tak_im))
    end
  end
end

-- 將內容寫入緩衝區
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

-- 將緩衝區顯示在新的窗口中
vim.api.nvim_command "vnew"
vim.api.nvim_command("buffer " .. buf)

-- -- 顯示查詢結果
-- if han_ji_dict then
--   print "=============================================="
--   print("【查找漢字】：" .. tostring(han_ji_dict["han_ji"]))
--   if han_ji_dict["tak_im_list"] and #han_ji_dict["tak_im_list"] > 0 then
--     for _, tak_im in ipairs(han_ji_dict["tak_im_list"]) do
--       print "----------------------------------------------"
--       print("【反切讀音】：" .. tak_im["huan_tshiat"])
--       print("【拼音字母】：" .. tak_im["piau_im"])
--       print("【查詢結果】：" .. vim.inspect(tak_im))
--     end
--   else
--     print "找不到反切讀音"
--   end
-- else
--   print "找不到反切讀音"
-- end
