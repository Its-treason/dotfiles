return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "hard",
    }
  },

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
