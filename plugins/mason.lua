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

local venv_python_path = get_venv_python_path()
local debugpy_python_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"

-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "lua_ls",
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
        "prettier",
        "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "python",
      })
      opts.handlers = {
        ---@diagnostic disable-next-line: unused-local
        python = function(source_name)
          local dap = require "dap"

          dap.configurations.python = {
            {
              type = "python",
              request = "launch",
              name = "Python: Launch file",
              program = "${file}",
            },
          }
          dap.adapters.python = {
            type = "executable",
            command = debugpy_python_path,
            args = {
              "-m",
              "debugpy.adapter",
            },
          }

          dap.configurations.python = {
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}", -- This configuration will launch the current file if used.
              pythonPath = venv_python_path,
            },
            {
              type = "python",
              request = "launch",
              name = "Launch Django Server",
              cwd = "${workspaceFolder}",
              program = "${workspaceFolder}/manage.py",
              args = {
                "runserver",
                "--noreload",
              },
              console = "integratedTerminal",
              justMyCode = true,
              pythonPath = venv_python_path,
            },
            {
              type = "python",
              request = "launch",
              name = "Python: Django Debug Single Test",
              program = "${workspaceFolder}/manage.py",
              args = {
                "test",
                "${relativeFileDirname}",
              },
              django = true,
              console = "integratedTerminal",
              pythonPath = venv_python_path,
              -- pythonPath = "${workspaceFolder}/.venv/bin/python",
            },
          }
        end,
      }
    end,
  },
}
