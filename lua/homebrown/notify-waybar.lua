local function send_message()
	vim.ui.input({ prompt = "Enter message to send: " }, function(input)
		local output = nil
		if input == "c" then
			output = vim.fn.system("wl-paste")
			if output == nil then
				vim.notify("Could not retireve 'wl-paste'")
				return
			end
		elseif input == "" then
			vim.notify("fuck you")
			return
		else
			output = input
		end
		local file = io.open("/tmp/sway_notify_test", "w")
		if file == nil then
			vim.notify("Could not open '/tmp/sway_notify_test'")
			return
		end
		file:write(output)
		file:close()
		os.execute("pkill -SIGRTMIN+5 waybar")
	end)
end
return {
	vim.keymap.set(
		"n",
		"<leader>ns",
		send_message,
		{ desc = "Send a message or clipboard to waybar", silent = true, noremap = true }
	),
}
