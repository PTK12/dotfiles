return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				file_ignore_patterns = { ".git/", ".cache/" },
				preview = {
					filesize_limit = 1,
				},
				layout_config = {
					prompt_position = "top",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
		telescope.load_extension("fzf")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fzf all files" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fzf git files" })
		keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fzf old files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Fzf string" })
	end,
}
