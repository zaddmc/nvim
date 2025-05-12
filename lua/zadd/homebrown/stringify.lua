return {
	vim.api.nvim_create_user_command("Stringify", function()
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")

		-- Get the lines
		local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

		-- Trim whitespace and escape quotes
		for i, line in ipairs(lines) do
			lines[i] = line:match("^%s*(.-)%s*$"):gsub('"', '\\"') -- trim + escape quotes
		end

		-- Join lines with \n and wrap in quotes
		local quoted = '"' .. table.concat(lines, '", "') .. '"'

		-- Replace selected lines with the quoted string
		vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, { quoted })
	end, { range = true }),

	vim.keymap.set("v", "<leader>s", ":Stringify<CR>", { noremap = true, silent = true }),
}
