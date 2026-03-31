return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
      },
      sections = {
        lualine_c = { "filename" },
        lualine_x = {
          {
            function()
              local ok, cmake = pcall(require, "cmake-tools")
              if ok then
                local target = cmake.get_launch_target()
                if target then
                  return "CMake: " .. target
                end
              end
              return ""
            end,
          },
          "encoding",
          "filetype",
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
