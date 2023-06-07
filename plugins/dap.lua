local dap = require "dap"
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- Python Debugger: "debugpy"
        "python",
        -- Node.js Debugger: "node-debug2-adapter"
        "node2",
        -- JavaScript Debugger: "js-debug-adapter"
        -- "js",
      })
      opts.handlers = {
        ---@diagnostic disable-next-line: unused-local
        node2 = function(source_name)
          dap.configurations.node2 = {
            {
              name = "Node2: Launch file",
              type = "node2",
              request = "launch",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              console = "integratedTerminal",
            },
            {
              name = "Node2: Attach to Process",
              type = "node2",
              request = "attach",
              processId = require("dap.utils").pick_process,
              -- program = "${file}",
              -- cwd = vim.fn.getcwd(),
              -- sourceMaps = true,
              -- protocol = "inspector",
              -- console = "integratedTerminal",
              -- skipFiles = {
              --   "<node_internals>/**",
              -- },
            },
          }
        end,
        -- ---@diagnostic disable-next-line: unused-local
        -- js = function(source_name)
        --   dap.configurations.js = {
        --     -- Node.js
        --     {
        --       type = "pwa-node",
        --       request = "launch",
        --       name = "Launch file",
        --       program = "${file}",
        --       cwd = "${workspaceFolder}",
        --     },
        --     {
        --       type = "pwa-node",
        --       request = "attach",
        --       name = "Attach",
        --       processId = require("dap.utils").pick_process,
        --       cwd = "${workspaceFolder}",
        --     },
        --     -- Jest
        --     {
        --       type = "pwa-node",
        --       request = "launch",
        --       name = "Debug Jest Tests",
        --       -- trace = true, -- include debugger info
        --       runtimeExecutable = "node",
        --       runtimeArgs = {
        --         "./node_modules/jest/bin/jest.js",
        --         "--runInBand",
        --       },
        --       rootPath = "${workspaceFolder}",
        --       cwd = "${workspaceFolder}",
        --       console = "integratedTerminal",
        --       internalConsoleOptions = "neverOpen",
        --     },
        --     -- Mocha
        --     {
        --       type = "pwa-node",
        --       request = "launch",
        --       name = "Debug Mocha Tests",
        --       -- trace = true, -- include debugger info
        --       runtimeExecutable = "node",
        --       runtimeArgs = {
        --         "./node_modules/mocha/bin/mocha.js",
        --       },
        --       rootPath = "${workspaceFolder}",
        --       cwd = "${workspaceFolder}",
        --       console = "integratedTerminal",
        --       internalConsoleOptions = "neverOpen",
        --     },
        --     {
        --       name = "Launch Program",
        --       type = "pwa-node",
        --       request = "launch",
        --       skipFiles = {
        --         "<node_internals>/**",
        --       },
        --       program = "${workspaceFolder}/bin/www",
        --       console = "integratedTerminal",
        --     },
        --     {
        --       name = "Launch app.js",
        --       type = "pwa-node",
        --       request = "launch",
        --       skipFiles = {
        --         "<node_internals>/**",
        --       },
        --       program = "${workspaceFolder}/app.js",
        --       console = "integratedTerminal",
        --     },
        --   }
        -- end,
        ---@diagnostic disable-next-line: unused-local
        python = function(source_name)
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
            command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
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
              pythonPath = get_venv_python_path(),
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
              pythonPath = get_venv_python_path(),
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
              pythonPath = get_venv_python_path(),
            },
          }
        end,
      }
    end,
  },
}
