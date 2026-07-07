-- Recommended code width
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "rust" },
    callback = function()
        vim.cmd("setlocal cc=120")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c" },
    callback = function()
        vim.cmd("setlocal cc=140")
        -- Fixes for common switch-case indentation jumps
        vim.opt_local.cinoptions = {
            ":0", -- Place case labels in the same column as the switch statement
            "l1", -- Indent case bodies relative to the case label
            "g0", -- Place C++ scope declarations (public, private) at same level
            "t0", -- Don't indent function return types
            "(0", -- Align with unclosed parentheses
        }
    end,
})

-- Set differnt tab widths
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "lua", "cs" },
    callback = function()
        vim.cmd("setlocal shiftwidth=4")
    end,
})

function _G.custom_foldtext()
    local bufnr = vim.api.nvim_get_current_buf()
    local row = vim.v.foldstart - 1 -- 0-indexed
    local line = vim.fn.getline(vim.v.foldstart)
    local chunks = {}

    local ok = pcall(function()
        local parser = vim.treesitter.get_parser(bufnr)
        parser:parse({ row, row })
        local lang = parser:lang()
        local query = vim.treesitter.query.get(lang, "highlights")
        if not query then
            return
        end

        local root = parser:parse()[1]:root()
        local hl_by_col = {}

        for id, node in query:iter_captures(root, bufnr, row, row + 1) do
            local s_row, s_col, e_row, e_col = node:range()
            local col_start = (s_row == row) and s_col or 0
            local col_end = (e_row == row) and e_col or #line
            local hl = "@" .. query.captures[id]
            for c = col_start, col_end - 1 do
                hl_by_col[c] = hl -- naive: later captures just overwrite earlier ones
            end
        end

        local col = 0
        while col < #line do
            local hl = hl_by_col[col] or "Normal"
            local start = col
            while col < #line and (hl_by_col[col] or "Normal") == hl do
                col = col + 1
            end
            table.insert(chunks, { line:sub(start + 1, col), hl })
        end
    end)

    if not ok or #chunks == 0 then
        chunks = { { line, "Normal" } }
    end

    local count = vim.v.foldend - vim.v.foldstart + 1
    table.insert(chunks, { string.format("  ⋯ %d lines", count), "Comment" })

    return chunks
end

vim.o.foldtext = "v:lua.custom_foldtext()"
