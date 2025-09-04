return {
    vim.keymap.set("n", "<leader>mf", function()
        vim.ui.input({ prompt = "Enter something: " }, function(input)
            print("You entered: " .. (input or ""))
        end)
    end),
}
