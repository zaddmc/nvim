return {
	"mistricky/codesnap.nvim",
	build = "make build-generator",
	version = "^1",
	lazy = "true",
	config = function()
		require("codesnap").setup({
			title = "no",
			mac_windows_bar = false,
			save_path = home("/screenshots/snap.png"),
		})
	end,
}
