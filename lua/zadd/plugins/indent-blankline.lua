return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        whitespace = { remove_blankline_trail = false },
    },
}
