return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          ensure_installed = { "codelldb" },
          automatic_installation = true,
        },
      },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        },
        config = function()
          local dapui = require("dapui")
          dapui.setup({
            element_mappings = {
              stacks = {
                open = "o",
                expand = "<CR>",
              },
            },
            floating = { border = "rounded" },
          })
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "dapui_stacks",
            callback = function(args)
              vim.keymap.set("n", "p", function()
                local stacks_win = vim.api.nvim_get_current_win()
                vim.cmd("normal o")
                vim.schedule(function()
                  vim.api.nvim_set_current_win(stacks_win)
                end)
              end, { buffer = args.buf, desc = "Preview stack frame" })
            end,
          })

          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            vim.defer_fn(function() dapui.open() end, 100)
          end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<F23>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional Breakpoint" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug: REPL" },
      { "<S-F5>", function()
        local dap = require("dap")
        local session = dap.session()
        if session and session.stopped_thread_id then
          dap.terminate()
        else
          dap.pause(0)
        end
      end, desc = "Debug: Pause / Terminate" },
      { "<F17>", function()
        local dap = require("dap")
        local session = dap.session()
        if session and session.stopped_thread_id then
          dap.terminate()
        else
          dap.pause(0)
        end
      end, desc = "Debug: Pause / Terminate" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Debug: Interrupt/Pause" },
    },
    config = function()
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          env = {
            INTERNAL_TEST_DATA_DIR = "/home/jlind/dev/zivid-sdk/sdk/test-data",
          },
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.cuda = dap.configurations.cpp

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })
    end,
  },
}
