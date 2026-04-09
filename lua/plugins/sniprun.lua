return {
    "michaelb/sniprun",
    build = "sh install.sh",
    keys = {
        { "<leader>ee", "<cmd>SnipRun<CR>", desc = "Run the code in visual with SnipRun", mode = { "v" } },
        { "<leader>rc", "<cmd>SnipClose<CR>", desc = "Close output of SnipRun", mode = { "n" } },
    },
}
