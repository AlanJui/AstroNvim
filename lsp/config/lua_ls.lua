-- 宣告模組（Module）搜尋路徑
local project_path = "~/workspace/lua/my_lua01/"

return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        -- version = "LuaJIT",
        version = "Lua 5.4",
        path = {
          "?.lua",
          "?/init.lua",
          vim.fn.expand "~/.luarocks/share/lua/5.4/?.lua",
          vim.fn.expand "~/.luarocks/share/lua/5.4/?/init.lua",
          vim.fn.expand "~/workspace/lua/my_lua01/lua_modules/share/lua/5.4/?.lua",
          vim.fn.expand "~/workspace/lua/my_lua01/lua_modules/share/lua/5.4/?/init.lua",
          "/usr/local/share/lua/5.4/?.lua",
          "/usr/local/share/lua/5.4/?/init.lua",
        },
      },
      diagnostics = {
        globals = { "vim", "hs" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          vim.fn.expand "~/workspace/lua/my_lua01/lua_modules/lib/lua/5.4/?.so",
          "/usr/lib/lua/5.4/?.so",
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
