return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon add file",
			},
			{
				"<leader>h",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Harpoon open quick menu",
			},
			{
				"<C-e>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Harpoon: Goto file 1",
			},
			{
				"<C-b>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Harpoon: Goto file 2",
			},
			{
				"<C-x>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Harpoon: Goto file 3",
			},
		},
	},

	-- Project.nvim
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			detection_methods = { "pattern" },
			patterns = { ".git", "package.json" },
			exclude_dirs = {
				"*node_modules/*",
			},
			manual_mode = false,
      silent_chdir = false,
			scope_dir = "global",
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)

			local telescope = require("telescope")
			telescope.load_extension("projects")
		end,
		keys = {
			{
				"<leader>o",
				"<cmd>Telescope projects<cr>",
				desc = "Open last projects",
			},
			{
				"<leader>up",
				"<cmd>ProjectRoot<cr>",
				desc = "Add dir to project list / Change root dir",
			},
		},
	},

	-- Scratch files
	{
		"Sonicfury/scretch.nvim",
		event = "VeryLazy",
		opts = {
			scretch_dir = vim.fn.stdpath("data") .. "/scretch/",
		},
		keys = {
			{
				"<leader>Sn",
				function()
					require("scretch").new()
				end,
				desc = "Create new scretch file",
			},
			{
				"<leader>SN",
				function()
					require("scretch").new_named()
				end,
				desc = "Create new named scretch file",
			},
			{
				"<leader>Sl",
				function()
					require("scretch").last()
				end,
				desc = "Open last scretch file",
			},
			{
				"<leader>So",
				function()
					require("scretch").explore()
				end,
				desc = "Explore scretch files",
			},
		},
	},
}
