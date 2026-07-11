return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "saghen/blink.cmp", "folke/lazydev.nvim" },
        config = function()
            local keymap = vim.keymap -- for conciseness
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    opts.desc = "See available code actions"
                    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "Smart rename"
                    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                    opts.desc = "Show line diagnostics"
                    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                    opts.desc = "Go to previous diagnostic"
                    keymap.set("n", "[d", vim.diagnostic.get_prev, opts)

                    opts.desc = "Go to next diagnostic"
                    keymap.set("n", "]d", vim.diagnostic.get_next, opts)
                end,
            })

            vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", { desc = "vim.lsp" })

            -- Change the Diagnostic symbols in the sign column (gutter)
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

            -- vim.lsp.config("*", {})
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = true,
                        },
                    },
                },
            })
            vim.lsp.enable({ "lua_ls", "zuban", "clangd" })
        end,
        opts = {
            inlay_hints = { enabled = true },
            folds = { enabled = true },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependancies = "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "zuban", -- Python LSP
                "black", -- Python Formatter
                "isort", -- Python Formatter for Imports
                "lua-language-server", -- Lua LSP
                "stylua", -- Lua Formatter
                "prettier", -- Frontend Formatter
                "biome", -- JSON Formatter
                "clangd", -- C LSP
                "clang-format", -- C Formatter
                "beautysh", -- SH Formatter
            },
        },
    },
}
