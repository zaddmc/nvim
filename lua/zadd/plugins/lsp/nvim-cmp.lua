return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "L3MON4D3/LuaSnip", -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
        "mtoohey31/cmp-fish",
        "folke/lazydev.nvim",
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
                col_offset = -3,
                side_padding = 0,
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-c>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-e>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "lazydev" }, -- Will only work in lua for better thing
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
                { name = "fish" },
            }),
            window = {
                completion = {
                    --winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -2,
                    --side_padding = 0,
                },
            },
            formatting = {
                fields = { "icon", "abbr", "menu", "kind" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({ mode = "text_symbol", maxwidth = 50 })(entry, vim_item)
                    --local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.icon = (kind.icon or "") .. " "
                    kind.kind = "   (" .. (kind.kind or "") .. ") "
                    --kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
                expandable_indicator = true,
            },
        })
    end,
}
