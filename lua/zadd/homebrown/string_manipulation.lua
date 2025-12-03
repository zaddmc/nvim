local function convert_to_bytearray(instr)
    local p = {}
    for str in string.gmatch(instr, "(%w%w)") do
        table.insert(p, "0x" .. str)
    end
    return table.concat(p, ", ")
end

return {
    vim.api.nvim_create_user_command("SplitStr0x", function()
        vim.ui.input({ prompt = "Enter string to split: " }, function(input)
            if input then
                local res = convert_to_bytearray(input)
                os.execute("wl-copy " .. res)
                vim.print("Will add to clipboard: " .. res)
            else
                vim.print("Failed")
            end
        end)
    end, {}),
    --vim.keymap.set("v", "<leader>mx", ":SplitStr0x<CR>", { noremap = true, silent = true }),
}
