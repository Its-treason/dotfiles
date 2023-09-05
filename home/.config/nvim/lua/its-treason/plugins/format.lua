return {
	{
		"nvimdev/guard.nvim",
		config = function()
			local ft = require("guard.filetype")

			ft("lua"):fmt("stylua")

			ft("typescript,javascript,typescriptreact"):fmt("prettier"):fmt({
				cmd = "eslint_d",
				args = { "--fix" },
				fname = true,
			})

			require("guard").setup({
				fmt_on_save = false,
				lsp_as_default_formatter = false,
			})
		end,
		keys = {
			{
				"<leader>cf",
				vim.cmd.GuardFmt,
				desc = "Format file",
			},
		},
	},

	-- Try to auto guess the files indents
	{
		"nmac427/guess-indent.nvim",
		cmd = { "GuessIndent" },
		event = "BufReadPre",
		opts = {},
	},
}
