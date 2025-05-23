vim.g.mapleader = " "

local keymap = vim.keymap

--keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"}) --Stupid

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying into register" })

-- increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- For local replace DOESNT SEEM TO WORK
--keymap.set(	"n",	"<leader>gr",	"gd[{V%::s/<C-R>///gc<left><left><left>",	{ desc = "Will replace the variable name under cursor in between curly brackets" })
-- For global replace
--keymap.set("n", "<leader>gR", "gD:%s/<C-R>///gc<left><left><left>",{ desc = "Will replace the variable name under cursor in whole document" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<C-b>", function()
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

-- Run in tmux
--[[ keymap.set(
	"n",
	"<leader>rt",
	':w<CR>:silent <C-w>v "source $VIRTUAL_ENV/bin/activate; python3 %; echo "Press Enter to close..."; <CR>',
	{ noremap = true, silent = true, desc = "Opens a terminal next to nvim to run python3 code" }
) ]]

keymap.set("n", "<C-e>", "<CR>")
