return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			server = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				eslint = {},
				cssls = {},

				phpactor = {
					init_options = {
						["language_server_phpstan.enabled"] = false,
						["language_server_psalm.enabled"] = false,
						["php_code_sniffer.enabled"] = false,
						["phpunit.enabled"] = true,
						["indexer.exclude_patterns"] = {
							"/vendor/**/Tests/**/*",
							"/vendor/**/tests/**/*",
							"/var/cache/**/*",
							"/vendor/composer/**/*",
						},
						["language_server.diagnostics_on_update"] = false,
					},
				},
				-- intelephense = {},

				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup({})
			local lsp_config = require("lspconfig")
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server_name, server_opts in pairs(opts.server) do
				server_opts.capabilities = default_capabilities
				lsp_config[server_name].setup(server_opts)
			end
		end,
		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
		},
	},

	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "LspAttach",
		opts = {},
	},

	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"gd",
				"<cmd>Lspsaga goto_definition<cr>",
				desc = "Goto definition",
			},
			{
				"gr",
				"<cmd>Lspsaga finder ref+imp<cr>",
				desc = "Goto References",
			},

			{
				"K",
				"<cmd>Lspsaga hover_doc<cr>",
				desc = "Hover docs",
			},

			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<cr>",
				desc = "Code action",
			},

			{
				"<C-t>",
				"<cmd>Lspsaga term_toggle<cr>",
				desc = "Toggle terminal",
				mode = { "n", "t" },
			},
		},
	},

	{
		"pmizio/typescript-tools.nvim",
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				tsserver_path = "/home/timon/.yarn/bin/tsserver",
			},
		},
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonUpdate" },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				-- PHP
				"phpactor",
				"phpmd",
				"phpcs",
				"phpstan",
				-- TS / JS
				"typescript-language-server",
				"eslint",
				"tsserver",
				"prettier",
				-- Ansible
				"ansible-language-server",
				"ansible-lint",
				-- Rust
				"rust-analyzer",
				"rustfmt",
				-- Docker
				"docker-compose-language-service",
				"dockerfile-language-server",
				-- Common
				"codespell",
				"tree-sitter-cli",
				"sqlls",
				"bash-language-server",
				"marksman", -- Markdown
				"nginx-language-server",
				"yaml-language-server",
			},
		},
	},
}
