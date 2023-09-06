return {
	{
		"nvimdev/guard.nvim",
		event = { "BufEnter", "BufNewFile" },
		cmd = "GuardFmt",
		config = function()
			local ft = require("guard.filetype")

			ft("lua"):fmt("stylua")

			ft("typescript,javascript,typescriptreact"):fmt("prettier"):fmt({
				fn = function()
					vim.cmd("EslintFixAll")
				end,
			})

			require("guard").setup({
				fmt_on_save = false,
				lsp_as_default_formatter = false,
			})
			vim.cmd.GuardEnable()
		end,
		keys = {
			{
				"<leader>cf",
				vim.cmd.GuardFmt,
				desc = "Format file (Guard)",
			},
		},
	},

	-- Try to auto guess the files indents
	{
		"nmac427/guess-indent.nvim",
		cmd = { "GuessIndent" },
		event = { "BufEnter", "BufNewFile" },
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufEnter", "BufNewFile" },
		opts = {
			enable = true,
			enable_rename = true,
			enable_close = true,
			enable_close_on_slash = false,
		},
	},
}
