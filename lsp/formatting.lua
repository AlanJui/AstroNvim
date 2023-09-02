return {
  -- customize lsp formatting options
  formatting = {
    -- control auto formatting on save
    format_on_save = {
      enabled = true, -- enable or disable format on save globally
      allow_filetypes = { -- enable format on save for specified filetypes only
        "go",
        "lua",
        "python",
        "html",
      },
      ignore_filetypes = { -- disable format on save for specified filetypes
        -- "python",
      },
    },
    disabled = { -- disable formatting capabilities for the listed language servers
      -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
      -- "lua_ls",
    },
    timeout_ms = 1000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   -- disable formatting for lua_ls
    --   -- if client.name == "lua_ls" then
    --   --   return false
    --   -- end
    --
    --   if client.name == "autopep8" then
    --     return false
    --   end
    --
    --   -- only enable null-ls for javascript files
    --   if vim.bo.filetype == "javascript" then
    --     return client.name == "null-ls"
    --   end
    --
    --   -- enable all other clients
    --   return true
    -- end,
  },
}
