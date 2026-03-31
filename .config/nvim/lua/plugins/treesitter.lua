return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "c", "cpp", "cmake", "lua", "python", "json", "yaml", "bash", "ninja", "cuda" },
    highlight = { enable = true },
    indent = { enable = true },
  },
  main = "nvim-treesitter",
}
