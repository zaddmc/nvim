return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            "~/.config/nvim/lua/zadd/plugins",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
