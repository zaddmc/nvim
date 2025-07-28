return {
	"mistricky/codesnap.nvim",
	build = "make",
	config = function()
		require("codesnap").setup({
			mac_window_bar = false,
			show_workspace = true,
			bg_x_padding = 0,
			bg_y_padding = 0,

			save_path = "~/screenshots/snap.png",
		})
	end,
}
