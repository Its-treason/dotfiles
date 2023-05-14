return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = { flavour = "mocha" },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
