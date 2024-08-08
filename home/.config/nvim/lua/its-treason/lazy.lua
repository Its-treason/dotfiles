local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("its-treason/plugins", {
  defaults = {
    lazy = true,
    version = false,
  },
  diff = {
    cmd = "diffview.nvim",
  },
  checker = {
    enabled  = true,
    notify = false,
  },
  change_detection = {
    -- Disable change detection, annoying as fuck when developing
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "netrwPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Set the colorscheme
vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
