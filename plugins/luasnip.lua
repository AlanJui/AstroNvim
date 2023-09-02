return {
  { -- override nvim-cmp plugin
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      -- this can be used if your configuration lives in ~/.config/nvim
      -- if your configuration lives in ~/.config/astronvim, the full path
      -- must be specified in the next line
      local config_dir = vim.fn.stdpath "config"
      local runtime_dir = vim.fn.stdpath "data"
      local package_root = runtime_dir .. "/lazy"

      require("luasnip.loaders.from_vscode").lazy_load {
        paths = {
          -- "./lua/user/snippets",
          config_dir .. "/lua/user/my-snippets",
          package_root .. "/friendly-snippets",
        },
      }

      -- extends filetypes supported by snippets
      require("luasnip").filetype_extend("javascript", { "javascriptreact" })
      require("luasnip").filetype_extend("vimwik", { "markdown" })
      require("luasnip").filetype_extend("markdown", { "css" })
      require("luasnip").filetype_extend("html", { "htmldjango" })
    end,
  },
}
