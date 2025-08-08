-- Substitute a hex value with a list of rgba values
return {
	vim.api.nvim_create_user_command("HexToRGBA", function()
		local line = vim.api.nvim_get_current_line()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local col = cursor[2] + 1

		for start_pos, hex in line:gmatch("()#%x%x%x%x%x%x()") do
			if col >= start_pos and col <= hex then
				s, e = start_pos, hex - 1
				match = line:sub(s, e)
				break
			end
		end

		if not match then
			vim.print("No hex string found")
			return
		end

		local r = tonumber(match:sub(2, 3), 16) / 255
		local g = tonumber(match:sub(4, 5), 16) / 255
		local b = tonumber(match:sub(6, 7), 16) / 255

		local rgba_str = string.format("[%.3f, %.3f, %.3f, 1]", r, g, b)

		local new_line = line:sub(1, s - 2) .. rgba_str .. line:sub(e + 2)
		vim.api.nvim_set_current_line(new_line)
	end, { range = true }),

	vim.keymap.set(
		"n",
		"<leader>ch",
		":HexToRGBA<CR>",
		{ noremap = true, silent = true, desc = "Convert Hex to RGBA list" }
	),
}
