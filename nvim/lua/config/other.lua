local function set_expandtab()
	local spaces = vim.fn.searchcount({ pattern = "^ ", max_count = 128 }).total
	local tabs = vim.fn.searchcount({ pattern = "^\t", max_count = 128 }).total

	-- Use default for new files
	if spaces ~= tabs then
		vim.opt_local.expandtab = spaces > tabs
	end
end

local function process(table, indent, last)
	-- Set default
	local size = 0
	if indent ~= nil then
		size = indent:len() - 1
	end

	local delta = math.abs(size - last)

	if delta ~= 0 then
		table[delta] = (table[delta] or 0) + 1
	end

	return size
end

local function set_shiftwidth()
	-- Leave if using tabs
	if not vim.opt_local.expandtab then
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, 128, false)
	local table = {}
	local last = 0

	for _, line in ipairs(lines) do
		local indent = line:match("^ +[^%s]")
		last = process(table, indent, last)
	end

	-- 4 spaces as default
	local best_size = 4
	local best_count = 0

	for size, count in pairs(table) do
		if best_count < count then
			best_size = size
			best_count = count
		end
	end

	vim.opt_local.shiftwidth = best_size
end

local function setup()
	set_expandtab()
	set_shiftwidth()
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = setup,
})

local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = false
opt.expandtab = true

opt.list = true
opt.listchars:append({
	tab = "| ",
})

local keymap = vim.keymap

keymap.set({ "n", "i" }, "<C-s>", "<Cmd>w<CR>")
keymap.set({ "n" }, "<Leader>s", setup)
