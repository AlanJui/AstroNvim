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
        "luacheck",
        "stylua",
        -- Python
        "pylint",
        "isort",
        "mypy",
        "pydocstyle",
        "flake8",
        "djlint",
        "djhtml",
        "autopep8",
        "black",
        -- Web
        "prettier",
        -- Markdown
        "markdownlint",
      })

      opts.handlers = {
        -- for prettier
        prettier = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettier.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        -- for prettierd
        prettierd = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        -- For eslint_d:
        eslint_d = function()
          require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with {
            condition = function(utils)
              return utils.root_has_file "package.json" or utils.root_has_file ".eslintrc.json" or utils.root_has_file ".eslintrc.js"
            end,
          })
        end,
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "python",
        -- "js",
        -- "node2",
      })
    end,
    cmd = { "DapInstall", "DapUninstall" },
  },
}
