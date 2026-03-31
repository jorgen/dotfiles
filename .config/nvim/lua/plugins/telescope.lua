return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.o$", "%.a$", "%.so$", "build/", "%.git/" },
      },
    })
    telescope.load_extension("fzf")
  end,
}
