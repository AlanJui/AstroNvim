-- 定義文章標題和注音/拼音方法
local title = "回鄉偶書"
local methods = {
  "十五音標音",
  "方音符號注音",
  "白話字拼音",
  "台羅拼音",
  "閩拼拼音",
}

-- 定義圖片的 URL
local img_url =
"https://www.newton.com.tw/img/f/b37/nBnauQWMwAjMwIDOwY2M3MTMxQWOlNDO0cDZ2UTO4M2MzkDZ3EmM0QjMlBzLtVGdp9yYpB3LltWahJ2Lt92YuUHZpFmYuMmczdWbp9yL6MHc0RHa.jpg"

local format = "《%s》【%s】\n"
    .. '<div class="separator" style="clear: both">\n'
    .. '  <a href="圖片" style="display: block; padding: 1em 0; text-align: center">\n'
    .. '    <img alt="" border="0" width="400" data-original-height="630" data-original-width="1200"\n'
    .. '      src="%s" />\n'
    .. "  </a>\n"
    .. "</div>\n"
    .. "\n"

-- 獲取當前緩衝區
local buf = vim.api.nvim_get_current_buf()

-- 製作每種注音/拼音方法的 HTML Tags
local lines = {}
for _, method in ipairs(methods) do
  local output = format:format(title, method, img_url)
  for line in output:gmatch "[^\n]+" do -- 將 output 按照行分割
    table.insert(lines, line)
  end
  table.insert(lines, "") -- 添加一個空行
end

-- 將 lines 寫入到 buffer 中
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
