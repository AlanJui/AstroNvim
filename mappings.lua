-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

local utils = require "astronvim.utils"
local get_icon = utils.get_icon

return {
  -- first key is the mode
  n = {
    -- <Esc>
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
    ["<A-Up>"] = { "<cmd>resize -2<CR>" },
    ["<A-Down>"] = { "<cmd>resize +2<CR>" },
    ["<A-Left>"] = { "<cmd>vertical resize +2<CR>" },
    ["<A-Right>"] = { "<cmd>vertical resize -2<CR>" },
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
    -- disable default bindings
    -- ["<leader>c"] = false,
    -- second key is the lefthand side of the map
    ["<leader>a"] = { name = get_icon("ActiveLSP", 1, true) .. "Actions" },
    ["<leader>ah"] = { ':let @/ = ""<CR>', desc = "remove search highlight" },
    ["<leader>at"] = { ":set filetype=htmldjango<CR>", desc = "set file type to django template" },
    ["<leader>aT"] = { ":set filetype=html<CR>", desc = "set file type to HTML" },
    ["<leader>al"] = { ":set wrap!<CR>", desc = "on/off line wrap" },
    ["<leader>an"] = { ":set nonumber!<CR>", desc = "on/off line-numbers" },
    ["<leader>aN"] = { ":set norelativenumber!<CR>", desc = "on/off relative line-numbers" },
    -- mappings seen under group name "Buffer"
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
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
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
