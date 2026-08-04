return {
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSUpdateSync" },
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- disable rtp plugin, as we only need its queries for mini.ai
					-- In case other textobject modules are enabled, we will load them
					-- once nvim-treesitter is loaded
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
			{ "nushell/tree-sitter-nu" },
		},
		opts = {
			ensure_installed = {
				"help",
				"javascript",
				"typescript",
				"rust",
				"php",
				"lua",
				"json",
				"mardown",
				"vim",
				"vimdoc",
				"yaml",
				"nu",
			},
			highlight = {
				enabled = true,

				disable = function(_lang, buf)
					local max_filesize = 500 * 1024 -- 500 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
	},
}

