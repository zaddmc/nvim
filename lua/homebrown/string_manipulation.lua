local function convert_to_bytearray(instr)
    local p = {}
    for str in string.gmatch(instr, "(%w%w)") do
        table.insert(p, "0x" .. str)
    end
    return table.concat(p, ", ")
end

local function calculate_ubx_checksum()
    -- 1. Get the visually selected text
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    local text = table.concat(lines, " ")

    -- 2. Extract hex values (0xXX or XX) into a table of numbers
    local bytes = {}
    for hex in text:gmatch("0x(%x+)") do
        table.insert(bytes, tonumber(hex, 16))
    end

    -- If 0x format wasn't found, try plain hex pairs
    if #bytes == 0 then
        for hex in text:gmatch("%x%x") do
            table.insert(bytes, tonumber(hex, 16))
        end
    end

    if #bytes < 4 then
        print("Not enough bytes selected")
        return
    end

    -- 3. Fletcher-16 Logic
    -- Logic starts from index 3 (skipping the two header bytes)
    -- And stops 2 bytes before the end (the placeholder checksum)
    local ck_a, ck_b = 0, 0

    for i = 3, (#bytes - 2) do
        ck_a = (ck_a + bytes[i]) % 256
        ck_b = (ck_b + ck_a) % 256
    end

    -- 4. Output the result
    local result = string.format("Checksum: 0x%02X, 0x%02X", ck_a, ck_b)
    vim.print(result)
    os.execute("wl-copy " .. result)

    -- Optional: Append to the buffer
    -- vim.api.nvim_put({string.format("0x%02X, 0x%02X", ck_a, ck_b)}, "c", true, true)
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
    vim.keymap.set("v", "<leader>mx", ":SplitStr0x<CR>", { noremap = true, silent = true }),

    vim.keymap.set("v", "<leader>mc", function()
        calculate_ubx_checksum()
    end, { noremap = true }),
}
