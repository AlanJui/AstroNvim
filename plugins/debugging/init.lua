return {
  --  +----------------------------------------------------------+
  --  |                          Debug                           |
  --  +----------------------------------------------------------+
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end,  desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,      desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
          local dap = require "dap"
          local dapui = require "dapui"
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close {}
          end
        end,
      },
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
      },
      { "nvim-telescope/telescope-dap.nvim" },
      -- nlua adapter
      {
        "jbyuki/one-small-step-for-vimkind",
        -- stylua: ignore
        keys = {
          { "<leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Start Lua Debugger Server" },
          { "<leader>dal", function() require("osv").run_this() end,              desc = "Launch Lua Script" },
        },
        config = require "user.plugins.debugging.nlua",
      },
      -- Python adapter
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>daP", function() require("dap-python").test_method() end, desc = "Adapter Python Server" },
          { "<leader>dap", function() require("dap-python").test_class() end,  desc = "Adapter Python" },
        },
        config = require "user.plugins.debugging.python",
      },
      -- JavaScript adapter
      { -- Debugger for DAP
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
      { -- Plugin for DAP in Neovim to use VSCode's JavaScript debugger
        "mxsdev/nvim-dap-vscode-js",
        keys = {},
        config = require "user.plugins.debugging.js",
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                                                                                                              desc =
        "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc =
      "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc =
      "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc =
      "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc =
      "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc =
      "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc =
      "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc =
      "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc =
      "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc =
      "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc =
      "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc =
      "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc =
      "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc =
      "Widgets" },
    },
    opts = {
      setup = {
        osv = function(_, _)
          require("plugins.debugging.lua").setup()
        end,
        python = function(_, _)
          require("plugins.debugging.python").setup()
        end,
        -- js = function(_, _)
        --   require("plugins.debugging.js").setup()
        -- end,
      },
    },
    config = function(plugin, opts)
      -- 設定除錯器在使用者介面上使用的圖徵符號（Icons）
      -- vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })
      local dap_icons = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = "💬",
      }
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(dap_icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end
    end,
  },
}
