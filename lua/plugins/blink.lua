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
                ["<C-c>"] = { "hide" },
                ["<C-e>"] = { "select_and_accept", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                --[[ ["."] = {
                    function(cmp)
                        if cmp.is_visible() then
                            if cmp.accept() then
                                vim.api.nvim_put({ "." }, "c", true, true)
                                return true
                            end
                        end
                        return false
                    end,
                    "fallback",
                }, ]]

                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            fuzzy = { implementation = "prefer_rust" },
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
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    lua = { "lazydev", inherit_defaults = true },
                },
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
