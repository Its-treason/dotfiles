return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			-- Deps
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Extensions
			"marilari88/neotest-vitest",
			"olimorris/neotest-phpunit",
		},
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-phpunit"),
				},
			})
		end,
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest Test",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run all tests in file",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.expand("."))
				end,
				desc = "Run all tests suits",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle output",
			},
		},
	},
}
