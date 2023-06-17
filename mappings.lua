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
    -- disable default bindings
    -- ["<leader>c"] = false,
    -- second key is the lefthand side of the map
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
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
