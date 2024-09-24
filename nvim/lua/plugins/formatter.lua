return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = {
				lua = require("formatter.filetypes.lua").stylua,
				python = require("formatter.filetypes.python").black,
				c = require("formatter.filetypes.c").clangformat,
				cpp = require("formatter.filetypes.cpp").clangformat,
				rust = require("formatter.filetypes.rust").rustfmt,
				java = function()
					return {
						exe = "clang-format",
						args = {
							"--style='{BasedOnStyle: google, IndentWidth: 4}'",
							"--assume-filename=.java",
						},
						stdin = true,
					}
				end,
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>F", "<cmd>Format<cr>", { desc = "Format" })
	end,
}
