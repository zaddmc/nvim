vim.cmd("let g:netrw_liststyle = 3") -- Make :Explore tree style

local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.softtabstop = 4
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

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

-- Hide the active snippet jump targets completely
vim.api.nvim_set_hl(0, "SnippetTabstop", { link = "None" })
