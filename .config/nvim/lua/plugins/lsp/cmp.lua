return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },

	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- lsp
		"hrsh7th/cmp-nvim-lua", -- lua
		"hrsh7th/cmp-buffer", -- buffer
		"hrsh7th/cmp-path", -- path
		"hrsh7th/cmp-cmdline", -- cmdline
		"hrsh7th/cmp-vsnip", -- vscode

		{ "L3MON4D3/LuaSnip", run = "make install_jsregexp" },
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- snippets
		"onsails/lspkind.nvim", -- vscode icons style
		"SergioRibera/cmp-env", -- env
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lsp_kind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "vsnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "codeium" },
				{ name = "git" },
				{ name = "dotenv" },
			},

			mapping = {
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = lsp_kind.cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
					symbol_map = { Codeium = "" },

					before = function(entry, vim_item)
						vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
						return vim_item
					end,
				}),
			},
		})

		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
