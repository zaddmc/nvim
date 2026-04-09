return {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    config = function()
        require("colorizer").setup({
            user_default_options = { names = false },
        })
    end,
}
