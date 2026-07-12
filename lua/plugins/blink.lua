return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "folke/lazydev.nvim",
            "bydlw98/blink-cmp-env",
            "saghen/blink.lib",
            "rafamadriz/friendly-snippets",
        },
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
                ["<CR>"] = { "select_and_accept", "fallback" },
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

                ["<C-S-K>"] = { "show_signature", "hide_signature", "fallback" },
            },
            fuzzy = { implementation = "prefer_rust" },
            signature = { enabled = true },
            completion = {
                trigger = {
                    prefetch_on_insert = true,
                },
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon", "label", "label_description", gap = 2 },
                            { "kind" },
                        },
                        cursorline_priority = 0,
                    },
                    auto_show_delay_ms = 0,
                },
                documentation = { auto_show = true, auto_show_delay_ms = 0 },
                ghost_text = { enabled = false },
                accept = { auto_brackets = { enabled = true } },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "env" },
                per_filetype = {
                    lua = { "lazydev", inherit_defaults = true },
                },
                providers = {
                    env = {
                        name = "Env",
                        module = "blink-cmp-env",
                        opts = {
                            -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
                            show_braces = false,
                            show_documentation_window = true,
                        },
                    },
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
        dependencies = { "saghen/blink.lib" },
        build = function()
            require("blink.pairs").download():pwait(60000)
        end,

        ---@module "blink.pairs"
        ---@type blink.pairs.config
        opts = {
            mappings = { enabled = true, cmdline = false },
            highlights = { enabled = true, groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" } },
        },
    },
}
