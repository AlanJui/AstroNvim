local function get_venv_python_path()
  local workspace_folder = vim.fn.getcwd()

  if vim.fn.executable(workspace_folder .. "/.venv/bin/python") then
    return workspace_folder .. "/.venv/bin/python"
  elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") then
    return workspace_folder .. "/venv/bin/python"
  elseif vim.fn.executable(os.getenv "VIRTUAL_ENV" .. "/bin/python") then
    return os.getenv("VIRTUAL_ENV" .. "/bin/python")
  else
    return "/usr/bin/python"
  end
end

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  -- colorscheme = "astrodark",
  colorscheme = "nightfly",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
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
        "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,

  -- plugins = {
  --   {
  --     "jay-babu/mason-nvim-dap.nvim",
  --     opts = {
  --       ensure_installed = {
  --         -- Python Debugger: "debugpy",
  --         "python",
  --         -- JavaScript Debugger: "js-debug-adapter",
  --         "js",
  --       },
  --     },
  --   },
  -- },
  -- dap = {
  --   adapters = {
  --     python = {
  --       type = "executable",
  --       command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
  --       args = { "-m", "debugpy.adapter" },
  --     },
  --   },
  --   configurations = {
  --     python = {
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Launch file",
  --         program = "${file}",
  --         pythonPath = function()
  --           -- debugpy supports launching an application with a different
  --           -- interpreter then the one used to launch debugpy itself.
  --           -- The code below looks for a `venv` or `.venv` folder in the
  --           -- current directly and uses the python within.
  --           -- You could adapt this - to for example use the `VIRTUAL_ENV`
  --           -- environment variable.
  --           local workspace_folder = vim.fn.getcwd()
  --
  --           if vim.fn.executable(workspace_folder .. "/.venv/bin/python") then
  --             return workspace_folder .. "/.venv/bin/python"
  --           elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") then
  --             return workspace_folder .. "/venv/bin/python"
  --           elseif vim.fn.executable(os.getenv "VIRTUAL_ENV" .. "/bin/python") then
  --             return os.getenv("VIRTUAL_ENV" .. "/bin/python")
  --           else
  --             return "/usr/bin/python"
  --           end
  --         end,
  --       },
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Launch file",
  --         program = "${file}", -- This configuration will launch the current file if used.
  --         pythonPath = get_venv_python_path(),
  --       },
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Launch Django Server",
  --         cwd = "${workspaceFolder}",
  --         program = "${workspaceFolder}/manage.py",
  --         args = {
  --           "runserver",
  --           "--noreload",
  --         },
  --         console = "integratedTerminal",
  --         justMyCode = true,
  --         pythonPath = get_venv_python_path(),
  --       },
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Python: Django Debug Single Test",
  --         program = "${workspaceFolder}/manage.py",
  --         args = {
  --           "test",
  --           "${relativeFileDirname}",
  --         },
  --         django = true,
  --         console = "integratedTerminal",
  --         pythonPath = get_venv_python_path(),
  --       },
  --     },
  --   },
  -- },
}
