return {
	vim.keymap.set("n", "<leader>ns", function()
		vim.ui.input({ prompt = "Enter message to send: " }, function(input)
			local file = io.open("/tmp/sway_notify_test", "w")
			if file == nil then
				return
			end
			file:write(input)
			file:close()
			os.execute("pkill -SIGRTMIN+5 waybar")
		end)
	end),
}
