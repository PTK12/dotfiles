return {
	"williamboman/mason.nvim",

	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup()
		mason_lspconfig.setup()
		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = require("cmp_nvim_lsp").default_capabilities()
				})
			end,
		})
	end,
}
