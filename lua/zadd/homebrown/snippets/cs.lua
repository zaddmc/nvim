local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

return {
    luasnip.snippet("break", fmt([[break;]], {})),
}
