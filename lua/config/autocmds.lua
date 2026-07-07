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
