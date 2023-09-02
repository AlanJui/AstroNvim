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
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
      "hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
    },
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "emoji", priority = 700 }, -- add new source
      }

      -- modify the mapping part of the table
      opts.mapping["<C-y>"] = cmp.mapping.complete()

      -- return the new table to be used
      return opts
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      -- run cmp setup
      cmp.setup(opts)

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
