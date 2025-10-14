return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                htmldjango = { "prettier" },
                json = { "biome" },
                jsonc = { "biome" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                c = { "clang_format" },
            },
            formatters = {
                clang_format = { args = { "-style={IndentWidth: 4}" } },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 1000, lsp_format = "fallback" }
            end,
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- Bang will disable for all buffers
                vim.g.disable_autoformat = true
            else
                vim.b.disable_autoformat = true
            end
        end, { desc = "Disable auto foramtting on save", bang = true })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.g.disable_autoformat = false
            vim.b.disable_autoformat = false
        end, { desc = "Enable auto formatting on save" })
    end,
}
