-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

local utils = require "astronvim.utils"
local get_icon = utils.get_icon

local sections = {
  f = { desc = get_icon("Search", 1, true) .. "Find" },
  p = { desc = get_icon("Package", 1, true) .. "Packages" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  S = { desc = get_icon("Session", 1, true) .. "Session" },
  t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
}

vim.cmd [[
  set listchars=tab:>-
  set list
]]

function _G.toggle_tab_chars()
  if vim.opt.list:get() then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end

return {
  n = {
    --------------------------------------------------------------------------
    -- setting a mapping to false will disable it
    --------------------------------------------------------------------------
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    --------------------------------------------------------------------------
    -- 常用指令
    --------------------------------------------------------------------------
    ["<leader>,"] = { ":Telescope buffers<CR>", desc = "Show buffers" },
    ["<leader><leader>"] = { "<c-^>", desc = "Quick Switch 2 Buffers" }, -- Switch between 2 buffers
    ["jk"] = { "<Esc>", desc = "Escape" },
    -- Move Line
    ["<A-j>"] = { ":m .+1<CR>==" },
    ["<A-k>"] = { ":m .-2<CR>==" },
    -- Move to window using the <ctrl> hjkl keys
    ["<C-h>"] = { "<C-w>h" },
    ["<C-j>"] = { "<C-w>j" },
    ["<C-k>"] = { "<C-w>k" },
    ["<C-l>"] = { "<C-w>l" },
    -- Resize window using <Alt> arrow keys
    ["<A-Down>"] = { "<cmd>resize -2<CR>" },
    ["<A-Up>"] = { "<cmd>resize +2<CR>" },
    ["<A-Left>"] = { "<cmd>vertical resize -2<CR>" },
    ["<A-Right>"] = { "<cmd>vertical resize +2<CR>" },
    -- Editing Tools
    ["<leader>uo"] = { "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
    -- ["<leader>uT"] = { "<cmd>TSJToggle<CR>", desc = "Split/Join Tree Node" },
    -- ["<leader>uT"] = { "<cmd>lua require('treesj').toggle()<CR>", desc = "Split/Join Tree Node" },
    -- ["<leader>uT"] = {
    --   function ()
    --     require('treesj').toggle({ split = { recursive=true } })
    --   end,
    --   desc = "Split/Join Tree Node",
    -- },
    ["<leader>uT"] = {
      require("treesj").toggle,
      desc = "Split/Join Tree Node",
    },
    ["<leader>a"] = { name = get_icon("ActiveLSP", 1, true) .. "Actions" },
    ["<leader>ah"] = { ':let @/ = ""<CR>', desc = "remove search highlight" },
    ["<leader>at"] = { ":set filetype=htmldjango<CR>", desc = "set file type to django template" },
    ["<leader>aT"] = { ":set filetype=html<CR>", desc = "set file type to HTML" },
    ["<leader>al"] = { ":set wrap!<CR>", desc = "on/off line wrap" },
    ["<leader>an"] = { ":set nonumber!<CR>", desc = "on/off line-numbers" },
    ["<leader>aN"] = { ":set norelativenumber!<CR>", desc = "on/off relative line-numbers" },
    ["<leader>ao"] = { utils.system_open, desc = "Open the file under cursor with system app" },

    --------------------------------------------------------------------------
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    ["<leader>bq"] = {
      function()
        require("astronvim.utils.buffer").close()
      end,
      desc = "Close buffer",
    },
    ["<leader>bQ"] = {
      function()
        require("astronvim.utils.buffer").close(0, true)
      end,
      desc = "Force close buffer",
    },

    --------------------------------------------------------------------------
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>L"] = { name = get_icon("ActiveLSP", 1, true) .. "Coding Tools" },
    ["<leader>Lo"] = { name = "Code Outline" },
    ["<leader>Lt"] = { name = "Tree Split/Join" },
    ["<leader>r"] = { name = get_icon("DiagnosticHint", 1, true) .. "Run/Build Code" },
    ["<leader>rd"] = { name = "Django" },
    ["<leader>rp"] = { name = "Python" },
    ["<leader>x"] = { name = get_icon("DiagnosticHint", 1, true) .. "Trouble" },
    ["<leader>U"] = { name = get_icon("DiagnosticHint", 1, true) .. "Utilities" },
    -- ["<leader>a"] = { "<cmd>echo 'Hello World!'<CR>", desc = "Say Hello" },

    --------------------------------------------------------------------------
    -- Git
    ["<leader>g"] = sections.g,
    ["<leader>ga"] = { "echo Git!!", desc = "顯示 Git" },
    ["]g"] = {
      function()
        require("gitsigns").next_hunk()
      end,
      desc = "Next Git hunk",
    },
    ["[g"] = {
      function()
        require("gitsigns").prev_hunk()
      end,
      desc = "Previous Git hunk",
    },
    ["<leader>gl"] = {
      function()
        require("gitsigns").blame_line()
      end,
      desc = "View Git blame",
    },
    ["<leader>gL"] = {
      function()
        require("gitsigns").blame_line { full = true }
      end,
      desc = "View full Git blame",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview Git hunk",
    },
    ["<leader>gh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset Git hunk",
    },
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "Reset Git buffer",
    },
    ["<leader>gs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage Git hunk",
    },
    ["<leader>gS"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      desc = "Stage Git buffer",
    },
    ["<leader>gu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "Unstage Git hunk",
    },
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      desc = "View Git diff",
    },
    ["<leader>ut"] = {
      "<cmd>lua _G.toggle_tab_chars()<CR>",
      desc = "啟用／關閉：顯示 Tab 字符",
    },
    ["<leader>Ub"] = { name = "Lua 工具箱" },
    -- Test
    ["<leader>Ub1"] = {
      "<cmd>luafile ~/.config/nvim/lua/user/my_libs/api_get.lua<CR>",
      desc = "Test API: GET",
    },
    ["<leader>Ub2"] = {
      "<cmd>luafile ~/.config/nvim/lua/user/my_libs/huan_tshiat_tsa_tak_im.lua<CR>",
      desc = "Test API: GET /huat_tshiat_tsa_tak_im",
    },
    ["<leader>Ubl"] = {
      "<cmd>Telescope file_browser cwd='~/.config/nvim/lua/user/my_libs'<CR>",
      desc = "瀏覽檔案",
    },
    ["<leader>UbL"] = {
      function()
        require("telescope.builtin").find_files {
          cwd = "~/.config/nvim/lua/user/my-libs/",
          attach_mappings = function(prompt_bufnr)
            local entry = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(":luafile " .. entry.path)
          end,
        }
      end,
      desc = "瀏覽及選用工具",
    },
    -- Utilities
    ["<leader>Ubb"] = {
      "<cmd>luafile " .. "~/.config/nvim/lua/user/my_libs/piau_im.lua<CR>",
      desc = "Blogger 工具",
    },
    -- Window
    ["<leader>w"] = { name = "", desc = get_icon("Window", 1, true) .. "Window" },
    -- split window
    ["<leader>w-"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
    ["<leader>w_"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    ["<leader>w|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    -- Move to window using the <ctrl> hjkl keys
    ["<leader>wf"] = { desc = "Move Focus" },
    ["<leader>wfh"] = { "<C-w>h", desc = "Move to Left Window" },
    ["<leader>wfj"] = { "<C-w>j", desc = "Move to Down Window" },
    ["<leader>wfk"] = { "<C-w>k", desc = "Move to Up Window" },
    ["<leader>wfl"] = { "<C-w>l", desc = "Move to Right Window" },
    -- Resize window using <Alt> arrow keys
    ["<leader>ws"] = { desc = "Resize Window" },
    ["<leader>ws<Up>"] = { "<cmd>resize -2<CR>", desc = "Up Side" },
    ["<leader>ws<Down>"] = { "<cmd>resize +2<CR>", desc = "Down Side" },
    ["<leader>ws<Left>"] = { "<cmd>vertical resize +2<CR>", desc = "Left Side" },
    ["<leader>ws<Right>"] = { "<cmd>vertical resize -2<CR>", desc = "Right Side" },
    -- Zoom-in/out window
    ["<leader>wi"] = { ":tabnew %<CR>", desc = "Zoom-in" },
    ["<leader>wo"] = { ":tabclose<CR>", desc = "Zoom-out" },
    ["<leader>wc"] = { ":close<CR>", desc = "Close window" },
  },
  v = {
    -- Move Line
    ["<A-j>"] = { ":m '>+1<CR>gv=gv" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv" },
    -- Better indent
    ["<"] = { "<gv", desc = "Indent Left" },
    [">"] = { ">gv", desc = "Indent Right" },
  },
  i = {
    -- Move Line
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
