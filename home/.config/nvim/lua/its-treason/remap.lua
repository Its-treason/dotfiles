vim.g.mapleader = " "

local map = vim.keymap.set

-- Move lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Ensure cursor is in centered
map("n", "<C-d>", "<C-d>zz");
map("n", "<C-u>", "<C-u>zz");

-- Paste without overwriting reg "
map("x", "<leader>p", "\"_dP")

-- Yank to clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- floating terminal
-- @type float_term LazyFloat | nil
local float_term = nil;
local function open_term()
  if float_term and float_term:buf_valid() then
    print("Toogle")
    float_term:toggle()
  else
    print("Open")
    float_term = require("lazy.util").float_term();
  end
end

function ToggleTerm()
  if float_term then
    print("Toggle!")
    float_term:toggle()
  else
    print(":(")
  end
end

map("n", "<leader>ft", open_term, { desc = "Terminal" })
map("n", "<C-t>", function ()
  if float_term then
    print("Toggle !")
    float_term:toggle()
  else
    print(":(")
  end
end, { desc = "Terminal" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-t>", function ()
  if float_term and float_term:buf_valid() then
    float_term:hide({ wipe = true })
    print(float_term:buf_valid())
  else
    print("dont?")
  end
end, { desc = "Toggle Term" })
