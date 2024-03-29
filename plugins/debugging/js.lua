return function()
  local ok, adapter = pcall(require, "dap-vscode-js")
  if not ok then
    return
  end

  local dap = require "dap"

  -- dap-vscode-js 插件的運作，需透過 JS Debugger Server 。而 Mason 安裝的 js-debug-adapter
  -- 並不是一個可執行檔，而是一個 node module ，因此無法直接指定 debugger_path 。
  -- debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
  --
  -- 經測試，JS Debugger Server 之安裝路徑，最好為手動安裝及建置（Build）：
  -- debugger_path = os.getenv "HOME" .. "/.local/share/vscode-js-debug",
  -- 或在 plugins.lua 自行指定安裝 Microsoft vscode-js-debug ：
  -- debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",

  adapter.setup {
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
  }

  for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
      -- Node.js
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      -- Jest
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      -- Mocha
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Mocha Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/mocha/bin/mocha.js",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      -- {
      --   name = "Launch Program",
      --   type = "pwa-node",
      --   request = "launch",
      --   skipFiles = {
      --     "<node_internals>/**",
      --   },
      --   program = "${workspaceFolder}/bin/www",
      --   console = "integratedTerminal",
      -- },
      -- {
      --   name = "Launch app.js",
      --   type = "pwa-node",
      --   request = "launch",
      --   skipFiles = {
      --     "<node_internals>/**",
      --   },
      --   program = "${workspaceFolder}/app.js",
      --   console = "integratedTerminal",
      -- },
    }
  end
end
