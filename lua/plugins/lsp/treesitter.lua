return {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "dockerfile",
            "gitignore",
            "html",
            "javascript",
            "json",
            "lua",
            "python",
            "query",
            "rust",
            "vim",
            "vimdoc",
            "yaml",
            "c_sharp",
        },
    },
    init = function()
        vim.treesitter.language.register("c_sharp", "cs")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "cs",
            callback = function(args)
                pcall(vim.treesitter.start, args.buf, "c_sharp")
            end,
        })
    end,
}
