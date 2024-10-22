return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = {
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
        },

        config = function ()
            require('luasnip.loaders.from_snipmate').lazy_load("./LuaSnip")
            local ls = require("luasnip")
            vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-f>", function() ls.jump(1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-b>", function() ls.jump(-1) end, {silent = true})
        end
    }
}

