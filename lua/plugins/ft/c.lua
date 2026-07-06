local c_header_group = vim.api.nvim_create_augroup("CHeaderPaste", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = c_header_group,
    pattern = { "c", "cpp" }, -- Triggers for C and C++ files
    callback = function()
        -- Check if the current file is a header file (.h, .hpp, .hxx)
        local current_file = vim.fn.expand("%:e")
        if current_file:match("^h") then
            -- Remap 'p' in normal mode
            vim.keymap.set("n", "p", function()
                local clipboard_content = vim.fn.getreg('"')

                -- Check if the text ends with '{' (ignoring trailing whitespace/newlines)
                if clipboard_content:match("{%s*$") then
                    -- Replace the last '{' with a ';'
                    local modified_content = clipboard_content:gsub("({)(%s*)$", ";%2")

                    -- Set the modified text to the register and paste it
                    vim.fn.setreg('"', modified_content)
                    vim.cmd("normal! p")

                    -- Restore the original content to your clipboard so it isn't permanently altered
                    vim.fn.setreg('"', clipboard_content)
                else
                    -- If it doesn't end in '{', just perform a normal clipboard paste
                    vim.cmd("normal! p")
                end
            end, { buffer = true, desc = "Paste and convert trailing '{' to ';' in headers" })
        end
    end,
})
return {}
