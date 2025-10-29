local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

return {
    luasnip.snippet(
        "withfile",
        fmt(
            [[
    with open("input.txt", "r") as file:
        DATA = {}
    ]],
            { luasnip.insert_node(1, "file.read().strip()") }
        )
    ),
}
