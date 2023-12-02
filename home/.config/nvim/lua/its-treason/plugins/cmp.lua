local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"zbirenbaum/copilot.lua",
			"zbirenbaum/copilot-cmp",
		},
		event = "InsertEnter",
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			return {
				completion = {
					completionopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						-- if cmp.visible() then
						-- 	cmp.select_next_item()
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						-- if cmp.visible() then
						-- 	cmp.select_prev_item()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "copilot" },
					{ name = "buffer" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			}
		end,
	},

	-- Snippets, required for nvim-cmp
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			-- Unlink the jump Node when switching modes so Tab doesn't jump to a random position
			local luasnip_fix_augroup = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*",
				callback = function()
					if
						((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
						and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
						and not require("luasnip").session.jump_active
					then
						require("luasnip").unlink_current()
					end
				end,
				group = luasnip_fix_augroup,
			})

			local ls = require("luasnip")

			ls.add_snippets('typescriptreact', {
				ls.parser.parse_snippet("fc", "const $1: React.FC = () => {\n  $0\n}\n\nexport default $1"),
				ls.parser.parse_snippet("fcp", "type $1Props = {\n  $2\n}\n\nconst $1: React.FC<$1Props> = ({ $4 }) => {\n  $0\n}\n\nexport default $1"),
				ls.parser.parse_snippet("isvg", "import { ReactComponent as $1 } from \"$2\";"),
				ls.parser.parse_snippet("uad", "const { $1 } = use$0;"),
			})

			ls.add_snippets('typescript', {
				ls.parser.parse_snippet("zi", "export type $1 = z.infer<typeof $0>"),
			})

			ls.setup({ history = false })
		end,
	},

	-- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
					keymap = {
						accept = "<M-CR>",
					}
        },
      })

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          -- vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
          -- vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
  },
	{
		"zbirenbaum/copilot-cmp",
		config = function ()
			require("copilot_cmp").setup()
		end
	},

	-- Autopairs
	{
		"echasnovski/mini.pairs",
		event = "BufReadPre",
		opts = {},
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = {},
	},
}
