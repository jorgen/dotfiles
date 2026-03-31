return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    integrations = {
      dap = true,
      dap_ui = true,
      mason = true,
      native_lsp = { enabled = true },
      telescope = true,
      treesitter = true,
      which_key = true,
      gitsigns = true,
      indent_blankline = { enabled = true },
      neotree = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
