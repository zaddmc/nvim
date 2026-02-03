return {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0-beta.17",
    config = function()
        require("codesnap").setup({
            copy = false,
            mac_window_bar = false,
            show_workspace = true,
            bg_x_padding = 0,
            bg_y_padding = 0,

            save_path = vim.fn.expand("~/Screenshots/codesnaps"),
        })
    end,
}
