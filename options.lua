local project_path = "/Users/alanjui/workspace/lua/my_lua01/"
package.path = project_path .. "lua_modules/share/lua/5.4/?.lua;" .. package.path
package.path = project_path .. "lua_modules/share/lua/5.4/?/init.lua;" .. package.path
package.cpath = project_path .. "lua_modules/lib/lua/5.4/?.so;" .. package.cpath

package.path = project_path .. "?.lua;" .. package.path
package.path = project_path .. "?/init.lua;" .. package.path

-- set vim options here (vim.<first_key>.<second_key> = value)
-- local python_dir_path = os.getenv "VIRTUAL_ENV" or (os.getenv "HOME" .. "/.pyenv/versions/venv-3.10.6")
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
    swapfile = false, -- sets vim.opt.swapfile
    backup = false, -- sets vim.opt.backup
    writebackup = false, -- sets vim.opt.writebackup
    clipboard = "unnamedplus", -- sets vim.opt.clipboard
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
    loaded_python2_provider = 0,
    -- loaded_python3_provider = 1,
    python3_host_prog = os.getenv "HOME" .. "/.pyenv/versions/3.10.6/envs/venv-3.10.6/bin/python",
    node_host_prog = os.getenv "HOME" .. "/n/lib/node_modules/neovim/bin/cli.js",
    loaded_ruby_provider = 0,
    loaded_perl_provider = 0,
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
