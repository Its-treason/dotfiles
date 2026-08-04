local opt = vim.opt

opt.expandtab = true -- Use Spaces instead of tabs
opt.shiftwidth = 2 -- Indent size
opt.shiftround = true -- Auto round indents
opt.tabstop = 2 -- Number of 2 a Tab does
opt.smartindent = true -- Insert indents automatically
opt.wrap = true -- Enable line wraps
opt.colorcolumn = "80,120" -- Show gutters at 80 and 120 characters
opt.ignorecase = true
opt.title = true

opt.scrolloff = 6 -- Always show 6 lines of context
opt.autowrite = true
opt.signcolumn = "yes"
opt.cursorline = true -- Enable highlighting of the current line
opt.list = true -- Show some invisible characters
opt.number = true -- Show line number
opt.relativenumber = true -- Line number should be relative

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.termguicolors = true

opt.updatetime = 50

opt.mouse = ""

-- Auto save
vim.cmd("au FocusLost * :wa")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

