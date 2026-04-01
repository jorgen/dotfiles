return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  keys = {
    { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake: Configure" },
    { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
    { "<leader>cB", "<cmd>CMakeSelectBuildTarget<cr>", desc = "CMake: Select Build Target" },
    { "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake: Debug" },
    { "<leader>ct", function()
      local cmake = require("cmake-tools")
      cmake.select_launch_target(false, function(result)
        if result:is_ok() then
          cmake.get_config().build_target = { result.data }
        end
      end)
    end, desc = "CMake: Select Target" },
    { "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMake: Select Preset" },
    { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
    { "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean" },
    { "<leader>ca", function() vim.ui.input({ prompt = "CMake launch args: " }, function(input) if input then vim.cmd("CMakeLaunchArgs " .. input) end end) end, desc = "CMake: Set Launch Args" },
    { "<leader>cs", "<cmd>CMakeTargetSettings<cr>", desc = "CMake: Target Settings" },
  },
  opts = {
    cmake_command = "cmake",
    cmake_build_directory = "build/${presetName}",
    cmake_build_options = { "-j" },
    cmake_compile_commands_options = {
      action = "lsp",
    },
    cmake_dap_configuration = {
      name = "CMake Debug",
      type = "codelldb",
      request = "launch",
      stopOnEntry = false,
    },
    cmake_executor = {
      name = "quickfix",
    },
    cmake_runner = {
      name = "terminal",
    },
    cmake_notifications = {
      runner = { enabled = true },
      executor = { enabled = true },
    },
  },
  config = function(_, opts)
    require("cmake-tools").setup(opts)

    vim.keymap.set("n", "<F5>", function()
      local dap = require("dap")
      if dap.session() then
        dap.continue()
      else
        local cmake = require("cmake-tools")
        if cmake.is_cmake_project() and cmake.has_cmake_preset() then
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and vim.api.nvim_buf_get_name(buf) ~= "" and vim.bo[buf].buftype == "" then
              vim.api.nvim_buf_call(buf, function() vim.cmd("write") end)
            end
          end
          vim.cmd("CMakeDebug")
        else
          dap.continue()
        end
      end
    end, { desc = "Build & Debug (CMake) / Continue (DAP)" })
  end,
}
