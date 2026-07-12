vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", function()
    vim.cmd.noh()
    vim.lsp.buf.clear_references()
    print("Cleared Highlights")
end, { desc = "Clear search highlights" })
keymap.set("n", "*", ":lua vim.lsp.buf.document_highlight()<CR>")

--
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying into register" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Window movemnt
keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move to left pane" })
keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move to right pane" })

-- Tabs
keymap.set("n", "<leader>to", function()
    vim.cmd.tabnew()
    local win = vim.api.nvim_get_current_win()
    -- vim.w[win].snacks_main = true
    Snacks.dashboard.open({ win = win })
end, { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

for i = 1, 10 do
    keymap.set("n", "<A-" .. i .. ">", "<cmd>tabn " .. i .. "<CR>", { desc = "Go to tab " .. i })
end

-- Boolean stuff
keymap.set("n", "<leader>b", function()
    local word = vim.fn.expand("<cword>")
    local rval = ""
    if word == "true" then
        rval = "m`ciwfalse<Esc>``"
    elseif word == "false" then
        rval = "m`ciwtrue<Esc>``"
    elseif word == "True" then
        rval = "m`ciwFalse<Esc>``"
    elseif word == "False" then
        rval = "m`ciwTrue<Esc>``"
    end
    return rval
end, { expr = true, desc = "Toggle boolean" })

keymap.set("n", "<C-e>", "<CR>")
