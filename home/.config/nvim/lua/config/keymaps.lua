-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "gr", function()
  require("telescope.builtin").lsp_references({ show_line = false })
end, { desc = "References" })
