return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          -- "yaml",
          "html",
          "css",
          "scss",
          "less",
          "javascript",
          "typescript",
          "vue",
          "json",
          "jsonc",
          "markdown",
          "handlebars",
        },
        extra_filetypes = {},
      },
      null_ls.builtins.diagnostics.pylint.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.code = diagnostic.message_id
        end,
      },
      null_ls.builtins.formatting.isort,
      -- null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.autopep8,
    }
    return config -- return final config table
  end,
}
