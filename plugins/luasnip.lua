return {
  {
    "L3MON4D3/LuaSnip",
    build = vim.fn.has "win32" ~= 0
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      -- Load your own custom vscode style snippets
      local config_dir = vim.fn.stdpath "config"
      local runtime_dir = vim.fn.stdpath "data"
      local package_root = runtime_dir .. "/lazy"

      require("luasnip.loaders.from_vscode").lazy_load {
        paths = {
          config_dir .. "/lua/user/my-snippets",
          package_root .. "/friendly-snippets",
        },
      }

      -- extends filetypes supported by snippets
      require("luasnip").filetype_extend("vimwik", { "markdown" })
      require("luasnip").filetype_extend("markdown", { "css" })
      require("luasnip").filetype_extend("html", { "htmldjango" })
    end,
  },
}
