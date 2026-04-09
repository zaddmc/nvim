return {
    vim.keymap.set("n", "<leader>mf", function()
        str_to_find = ""
        vim.ui.input({ prompt = "Enter something: " }, function(input)
            print("You entered: " .. (input or ""))
            str_to_find = input
        end)
        str_to_replace = ""
        vim.ui.input({ prompt = "Enter something: " }, function(input)
            print("You entered: " .. (input or ""))
            str_to_replace = input
        end)
        vim.call(":%s/")
    end),
}
