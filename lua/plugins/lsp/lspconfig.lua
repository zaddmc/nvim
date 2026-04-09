return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "folke/lazydev.nvim",
    },
    config = function()
        local blink_cmp = require("blink.cmp")
        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

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

                --[[ opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) ]]

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        vim.o.winborder = "rounded"

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

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = blink_cmp.get_lsp_capabilities()

        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })
    end,
    opts = {
        inlay_hints = { enabled = true },
    },
}
