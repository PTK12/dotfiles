return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/vim-vsnip",
		"hrsh7th/vim-vsnip-integ",
	},
	config = function()
		local cmp = require("cmp")
		vim.opt.completeopt = { "menu", "menuone", "longest" }

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),

				-- Accept currently selected item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end),
			}),
			sources = {
				{ name = "nvim_lsp", max_item_count = 16 },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader><Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show docs" })
	end,
}
