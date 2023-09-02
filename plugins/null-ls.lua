return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- formatting
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.pylint.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.code = diagnostic.message_id
        end,
      },
      null_ls.builtins.diagnostics.mypy.with {
        extra_args = { "--config-file", "mypy.ini" },
      },
      null_ls.builtins.diagnostics.pydocstyle.with {
        extra_args = { "--config=$ROOT/setup.cfg" },
      },
      null_ls.builtins.diagnostics.flake8.with {
        diagnostics_format = "#{message} (#{code})",
      },
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.djhtml,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.markdown_toc, -- Markdown
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.diagnostics.eslint_d, -- Web Tools
      null_ls.builtins.diagnostics.stylelint,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.prettier.with {
        extra_args = { "--single-quote", "false" },
        filetypes = {
          "html",
          "css",
          "scss",
          "less",
          "javascript",
          "typescript",
          "vue",
          "json",
          "jsonc",
          "yaml",
          "markdown",
          "handlebars",
        },
        extra_filetypes = {},
      },
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.jq,

      -- diagnostics
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.diagnostics.standardrb,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.zsh,

      -- code actions
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.gitrebase,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.shellcheck,
    }
    return config -- return final config table
  end,
}
