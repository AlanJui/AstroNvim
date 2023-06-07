-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- Shell Script
        "bashls",
        -- Lua Script
        "lua_ls",
        -- Python
        "pyright",
        -- Web: HTML, CSS, JavaScript
        "cssls",
        "emmet_ls",
        "html",
        "jsonls",
        "tsserver",
        -- Markdown
        "marksman",
        -- configuration
        "taplo", -- TOML
        "yamlls",
        "lemminx", -- XML
        -- Others
        "julials",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- Shell Script
        "shellcheck",
        "shfmt",
        -- Lua Script
        "stylua",
        -- Python
        "pylint",
        "isort",
        "mypy",
        "pydocstyle",
        "flake8",
        "djlint",
        "autopep8",
        -- Web
        "prettier",
      })
    end,
  },
}
