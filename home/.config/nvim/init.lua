vim.cmd("au FocusLost * :wa")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
