return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
        build = "cargo build --release",

        ---@module "blink.cmp"
        ---@type blink.cmp.config
        opts = {
            keymap = {
                preset = "none",

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },

                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "select_and_accept", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                --["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
            completion = {
                menu = {
                    draw = {
                        padding = { 0, 1 },
                        columns = {
                            { "kind_icon", "label", "label_description", gap = 2 },
                            { "kind" },
                        },
                    },
                },
                ghost_text = { enabled = false },
                accept = { auto_brackets = { enabled = true } },
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    snippets = {
                        opts = {
                            search_paths = {
                                "~/.config/nvim/lua/zadd/homebrown/snippets/",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "saghen/blink.pairs",
        version = "*",
        dependencies = { "saghen/blink.download" },
        --build = "cargo build --release",

        ---@module "blink.pairs"
        ---@type blink.pairs.config
        opts = {
            mappings = { enabled = true, cmdline = false },
            highlights = { enabled = false },
        },
    },
}
